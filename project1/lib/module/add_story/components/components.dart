import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:project1/module/add_story/camera/camera_add_story_screen.dart';
import 'package:project1/module/add_story/cubit/add_story_cubit.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/icon_broken.dart';

Widget albumBottomSheet({AddStoryCubit? cubit, double? height}) => SizedBox(
      height: height,
      child: Card(
        child: ListView.separated(
          itemCount: cubit!.firstImagesFromAllAlbumAndName!.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: getProportionateScreenHeight(3)),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                cubit.getNewCurrentAlbum(
                    albumNew:
                        cubit.firstImagesFromAllAlbumAndName![index].album);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  FutureBuilder<Uint8List?>(
                    future: cubit.firstImagesFromAllAlbumAndName![index].image!
                        .thumbnailData,
                    builder: (context, snapshot) {
                      final bytes = snapshot.data;

                      if (bytes == null)
                        return SizedBox(
                          height: getProportionateScreenHeight(65),
                          width: getProportionateScreenWidth(65),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      return Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: getProportionateScreenHeight(65),
                            width: getProportionateScreenWidth(65),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                image: MemoryImage(
                                  bytes,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (cubit.firstImagesFromAllAlbumAndName![index]
                                  .image!.type ==
                              AssetType.video)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  Text(
                      cubit.firstImagesFromAllAlbumAndName![index].album!.name),
                ],
              ),
            );
          },
        ),
      ),
    );

Widget cameraGallery({context, cameras, controller}) => GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraAddStoryScreen(cameras: cameras),
            ));
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(240),
            child: AspectRatio(
              aspectRatio: 1 / controller!.value.aspectRatio,
              child: CameraPreview(controller!),
            ),
          ),
          Icon(
            IconBroken.Camera,
            color: Colors.white30,
            size: getProportionateScreenHeight(48),
          ),
        ],
      ),
    );
