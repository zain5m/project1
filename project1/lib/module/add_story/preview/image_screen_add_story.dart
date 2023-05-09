import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/models/story/story_model.dart';
import 'package:project1/module/add_story/cubit/add_story_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';
import 'package:video_player/video_player.dart';

class ImageScreenAddStory extends StatelessWidget {
  ImageScreenAddStory({
    required this.imageFile,
  });

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<File?>(
    //   future: imageFile,
    //   builder: (_, snapshot) {
    //     final file = snapshot.data;
    //     if (file == null) return Container();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            IconBroken.Arrow___Left_2,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: BlocProvider(
              create: (context) => AddStoryCubit(),
              child: BlocConsumer<AddStoryCubit, AddStoryStates>(
                listener: (context, state) {
                  if (state is AddStoryPostSucssesState) {
                    navigateAndFinish(context, AppLayout());
                  }
                },
                builder: (context, state) {
                  AddStoryCubit cubit = AddStoryCubit.get(context);
                  return TextButton(
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        fontSize: 18,
                        color: defaultColor,
                      ),
                    ),
                    onPressed: () {
                      cubit.postStory(
                        story: imageFile,
                        type: Photo,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Image.file(
          imageFile!,
        ),
      ),
    );
    // },
    // );
  }
}
