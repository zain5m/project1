import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/module/camera/asset_thumbnail.dart';
import 'package:project1/module/camera/camera_screen.dart';
import 'package:project1/module/camera/components/components.dart';
import 'package:project1/module/camera/cubit/image_cubit.dart';
import 'package:project1/module/intersts/interests_screen.dart';
import 'package:project1/module/register/cubit/register_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';

class AddPhotoRegisterScreen extends StatelessWidget {
  static String routeName = "/addPhotoRegisterScreen";
  File? image;
  AddPhotoRegisterScreen({this.image});
  GlobalKey keyForBack = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => ImageCubit()..getAlbums(image: image),
      child: BlocConsumer<ImageCubit, ImageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ImageCubit cubitImage = ImageCubit().get(context);
          return SafeArea(
            child: Scaffold(
              body: NestedScrollView(
                floatHeaderSlivers: true,
                physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    BlocProvider(
                      create: (context) => RegisterCubit(),
                      child: BlocConsumer<RegisterCubit, RegisterStates>(
                        listener: (context, state) {
                          if (state is RegisterAddPhotoErrorState) {
                            showToast(
                              text: state.error,
                              state: ToastState.ERROR,
                            );
                          } else if (state is RegisterAddPhotoSuccessState) {
                            navigateTo(context, InterestsScreen());
                          }
                        },
                        builder: (context, state) {
                          RegisterCubit registercubit =
                              RegisterCubit.get(context);
                          return defaultSliverAppBarTopToGallery(
                            cubit: cubitImage,
                            context: context,
                            title: 'Add Profile Picture',
                            onPressedTextButton: () {
                              registercubit.userRegisterAddPhoto(
                                image: cubitImage.currentImage!,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    defaultSliverAppBarCenterToGallery(
                      keyForBack: keyForBack,
                      child: state is! ImageGetCurrentImageSucssesState
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : cubitImage.currentImage != null
                              ? CircleAvatar(
                                  radius: getProportionateScreenHeight(190),
                                  backgroundImage: FileImage(
                                    cubitImage.currentImage!,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: getProportionateScreenHeight(190),
                                  backgroundImage: AssetImage(
                                    'assets/images/profile.png',
                                  ),
                                ),
                    ),
                    defaultSliverAppBarEndToGallery(
                      onPressedIconButton: () {
                        availableCameras().then((value) {
                          navigateTo(
                              context,
                              CameraScreen(
                                cameras: value,
                                tikePictureNavigator: 'addphoto',
                              ));
                        }).catchError((e) {
                          print(e.toString());
                        });
                      },
                      cubit: cubitImage,
                      widgit: BlocProvider(
                        create: (context) => RegisterCubit(),
                        child: BlocConsumer<RegisterCubit, RegisterStates>(
                          listener: (context, state) {
                            if (state is RegisterAddPhotoErrorState) {
                              showToast(
                                text: state.error,
                                state: ToastState.ERROR,
                              );
                            } else if (state is RegisterAddPhotoSuccessState) {
                              navigateTo(context, InterestsScreen());
                            }
                          },
                          builder: (context, state) {
                            RegisterCubit registercubit =
                                RegisterCubit.get(context);
                            return TextButton(
                              child: Text('Skip'),
                              onPressed: () async {
                                navigateTo(context, InterestsScreen());
                              },
                            );
                          },
                        ),
                      ),
                      onChangedDropdownButton: (String? value) {
                        if (state is ImageGetCurrentImageSucssesState)
                          cubitImage.getdropdownValue(value);
                      },
                    ),
                  ];
                },
                body: Center(
                  child: state is! ImageGetCurrentImageSucssesState
                      // &&
                      // state is! ImageGetCurrentImageSucssesState
                      ? CircularProgressIndicator()
                      : cubitImage.imageFromAlbum!.isEmpty
                          ? Center(
                              child: Text(
                                'Oops There are no pictures in this Album',
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemCount: cubitImage.imageFromAlbum!.length,
                              itemBuilder: (context, index) {
                                return AssetThumbnail(
                                  asset: cubitImage.imageFromAlbum![index],
                                  keyForBack: keyForBack,
                                  cubit: cubitImage,
                                );
                              },
                            ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
