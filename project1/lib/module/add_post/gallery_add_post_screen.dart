import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/module/add_post/add_post_screen.dart';
import 'package:project1/module/camera/asset_thumbnail.dart';
import 'package:project1/module/camera/camera_screen.dart';
import 'package:project1/module/camera/components/components.dart';
import 'package:project1/module/camera/cubit/image_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/routes/routes.dart';

class GalleryAddPostScreen extends StatelessWidget {
  static String routeName = "/GalleryAddPostScreen";
  File? image;
  GalleryAddPostScreen({this.image});
  GlobalKey keyForBack = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit()..getAlbums(image: image),
      child: BlocConsumer<ImageCubit, ImageStates>(
        listener: (context, state) {
          ImageCubit cubit = ImageCubit().get(context);
          // if (state is ImageGetCurrentImageSucssesState) {
          //   cubit.changeIsPhoto(true);
          //   print(ImageCubit().get(context).isphoto);
          // }
          // if (state is ImageGetCurrentImageInitialState) {
          //   cubit.changeIsPhoto(false);
          //   print(ImageCubit().get(context).isphoto);
          // }
        },
        builder: (context, state) {
          ImageCubit cubit = ImageCubit().get(context);
          return SafeArea(
            child: Scaffold(
              body: NestedScrollView(
                floatHeaderSlivers: true,
                physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    defaultSliverAppBarTopToGallery(
                      cubit: cubit,
                      context: context,
                      title: 'Add Post',
                      onPressedTextButton: () {
                        navigateTo(
                          context,
                          AddPostScreen(
                            image: cubit.currentImage,
                          ),
                        );
                      },
                    ),
                    defaultSliverAppBarCenterToGallery(
                      keyForBack: keyForBack,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: state is! ImageGetCurrentImageSucssesState
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : cubit.currentImage != null
                                ? Image.file(
                                    cubit.currentImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: getProportionateScreenHeight(295),
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    height: getProportionateScreenHeight(295),
                                    child: Center(
                                      child: Text(
                                          'Oops There are no pictures in this Album'),
                                    ),
                                  ),
                      ),
                    ),
                    defaultSliverAppBarEndToGallery(
                      cubit: cubit,
                      onPressedIconButton: () {
                        availableCameras().then((value) {
                          navigateTo(
                            context,
                            CameraScreen(
                              cameras: value,
                              tikePictureNavigator: 'addpost',
                            ),
                          );
                        }).catchError((e) {
                          print(e.toString());
                        });
                      },
                      onChangedDropdownButton: (String? value) {
                        if (state is ImageGetCurrentImageSucssesState)
                          cubit.getdropdownValue(value);
                      },
                    ),
                  ];
                },
                body: Center(
                  child: state is! ImageGetCurrentImageSucssesState
                      ? CircularProgressIndicator()
                      : cubit.imageFromAlbum!.isEmpty
                          ? SizedBox(
                              width: 329,
                              height: 295,
                              child: Center(
                                child: Text(
                                  'Oops There are no pictures in this Album',
                                ),
                              ),
                            )
                          : GridView.builder(
                              // physics: const NeverScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                              ),
                              itemCount: cubit.imageFromAlbum!.length,
                              itemBuilder: (context, index) {
                                print(cubit.imageFromAlbum!.length);
                                return AssetThumbnail(
                                  asset: cubit.imageFromAlbum![index],
                                  keyForBack: keyForBack,
                                  cubit: cubit,
                                );
                              },
                            ),
                ),
              ),

              // body:
            ),
          );
        },
      ),
    );
  }
}
