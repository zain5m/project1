import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/models/story/story_model.dart';
import 'package:project1/module/add_story/cubit/add_story_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/styes/icon_broken.dart';
import 'package:video_player/video_player.dart';

class VideoScreenAddStory extends StatefulWidget {
  final File? videoFile;

  const VideoScreenAddStory({
    required this.videoFile,
  });

  @override
  _VideoScreenAddStoryState createState() => _VideoScreenAddStoryState();
}

class _VideoScreenAddStoryState extends State<VideoScreenAddStory> {
  VideoPlayerController? _controller;
  bool initialized = false;

  get defaultColor => null;

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  _initVideo() async {
    // final video = await widget.videoFile;
    _controller = VideoPlayerController.file(widget.videoFile!)
      ..setLooping(true)
      ..initialize().then((_) => setState(() => initialized = true));
  }

  @override
  Widget build(BuildContext context) {
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
                        story: widget.videoFile!,
                        type: Video,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: initialized
          // If the video is initialized, display it
          ? Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Wrap the play or pause in a call to `setState`. This ensures the
                        // correct icon is shown.
                        setState(() {
                          // If the video is playing, pause it.
                          if (_controller!.value.isPlaying) {
                            _controller!.pause();
                          } else {
                            // If the video is paused, play it.
                            _controller!.play();
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _controller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          // If the video is not yet initialized, display a spinner
          : Center(
              child: Center(
                  child: CircularProgressIndicator(
                color: defaultColor,
              )),
            ),
    );
  }
}
