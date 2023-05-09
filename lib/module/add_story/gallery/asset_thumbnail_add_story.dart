import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:project1/module/add_story/preview/image_screen_add_story.dart';
import 'package:project1/module/add_story/preview/video_screen_add_story.dart';
import 'package:project1/shared/components/components.dart';

class AssetThumbnailAddStory extends StatelessWidget {
  final AssetEntity? asset;
  AssetThumbnailAddStory({
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset!.thumbnailData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) return Center(child: CircularProgressIndicator());
        return InkWell(
          onTap: () {
            asset!.file.then((value) {
              navigateTo(
                context,
                asset!.type == AssetType.image
                    ?
                    // If this is an image, navigate to ImageScreen
                    ImageScreenAddStory(imageFile: File(value!.path))
                    // if it's not, navigate to VideoScreen
                    : VideoScreenAddStory(videoFile: File(value!.path)),
              );
            });
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(
                      bytes,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (asset!.type == AssetType.video)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
