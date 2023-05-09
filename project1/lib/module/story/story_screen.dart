import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/models/home_post/home_post_model.dart';
import 'package:project1/models/story/story_model.dart';
import 'package:project1/module/story/animated_bar.dart';
import 'package:project1/module/story/story_user_info.dart';
import 'package:project1/shared/network/remote/end_points.dart';

import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  UserStoryModel? user;
  List<UserStoryModel>? users;
  StoryScreen({
    required this.user,
    required this.users,
  });

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  PageController? _pageController2;

  AnimationController? _animController;
  VideoPlayerController? _videoController;
  int _currentIndex = 0;
  late int initialpage;

  @override
  void initState() {
    super.initState();

    initialpage = widget.users!.indexOf(widget.user!);
    _pageController = PageController(
      initialPage: initialpage,
    );

    _pageController2 = PageController(
      initialPage: _currentIndex,
    );
    _animController = AnimationController(vsync: this);

    final Story firstStory = widget.user!.story!.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController!.stop();
        _animController!.reset();
        setState(() {
          if (_currentIndex + 1 < widget.users![initialpage].story!.length) {
            _currentIndex += 1;
            _loadStory(story: widget.users![initialpage].story![_currentIndex]);
          } else {
            // Out of bounds - loop story
            // You can also Navigator.of(context).pop() here
            if (initialpage + 1 < widget.users!.length) {
              // ! Next User Story
              initialpage += 1;
              _currentIndex = 0;
              _loadStory(
                story: widget.users![initialpage].story![_currentIndex],
                animateToPage: false,
                animateToUser: true,
              );
            } else {
              // !  finsh User Story
              Navigator.pop(context);
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    _pageController2!.dispose();
    _animController!.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  // Future<http.Response> getUrlResponse(String? imageUrl) {
  //   return http.get(Uri.parse(imageUrl!));
  // }

  @override
  Widget build(BuildContext context) {
    // final Story story = widget.user!.storys![_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: widget.users!.length,
        itemBuilder: (context, indexUser) {
          UserStoryModel user = widget.users![indexUser];
          return GestureDetector(
            onHorizontalDragEnd: (dragEndDetails) {
              //! Move page forwards
              if (dragEndDetails.primaryVelocity! < 0) {
                setState(() {
                  if (initialpage + 1 < widget.users!.length) {
                    // ! Next forwards User Story
                    initialpage += 1;
                    _currentIndex = 0;
                    _loadStory(
                      story: widget.users![initialpage].story![_currentIndex],
                      animateToPage: false,
                      animateToUser: true,
                    );
                  } else {
                    // !  finsh forwards  User Story

                  }
                });
              }
              //! Move page backwards
              else if (dragEndDetails.primaryVelocity! > 0) {
                setState(() {
                  if (initialpage - 1 >= 0) {
                    // ! backwards User Story
                    initialpage -= 1;
                    _currentIndex =
                        widget.users![initialpage].story!.length - 1;
                    _loadStory(
                      story: widget.users![initialpage].story![_currentIndex],
                      animateToPage: false,
                      animateToUser: true,
                    );
                  } else {
                    // !finsh backwards User Story

                  }
                });
                // _pageController!.previousPage(
                //   duration: Duration(milliseconds: 500),
                //   curve: Curves.easeIn,
                // );
              }
            },
            onLongPress: () {
              if (widget.users![initialpage].story![_currentIndex].dateType ==
                  Video) {
                _videoController!.pause();
                _animController!.stop();
              } else {
                _animController!.stop();
              }
            },

            onLongPressUp: () {
              if (widget.users![initialpage].story![_currentIndex].dateType ==
                  Video) {
                _videoController!.play();
                _animController!.forward();
              } else {
                _animController!.forward();
              }
            },
            onTapDown: (details) {
              final double screenWidth = MediaQuery.of(context).size.width;
              final double dx = details.globalPosition.dx;

              if (dx < screenWidth / 3) {
                setState(() {
                  if (_currentIndex - 1 >= 0) {
                    // ! backwards Story
                    _currentIndex -= 1;
                    _loadStory(
                        story:
                            widget.users![initialpage].story![_currentIndex]);
                  } else {
                    if (initialpage - 1 >= 0) {
                      // ! backwards User Story
                      initialpage -= 1;
                      _currentIndex =
                          widget.users![initialpage].story!.length - 1;
                      _loadStory(
                        story: widget.users![initialpage].story![_currentIndex],
                        animateToPage: false,
                        animateToUser: true,
                      );
                    } else {
                      // !finsh backwards User Story
                    }
                  }
                });
              } else if (dx > 2 * screenWidth / 3) {
                setState(() {
                  if (_currentIndex + 1 <
                      widget.users![initialpage].story!.length) {
                    // ! Next Story
                    _currentIndex += 1;
                    _loadStory(
                        story:
                            widget.users![initialpage].story![_currentIndex]);
                  } else {
                    if (initialpage + 1 < widget.users!.length) {
                      // ! Next User Story
                      initialpage += 1;
                      _currentIndex = 0;
                      _loadStory(
                        story: widget.users![initialpage].story![_currentIndex],
                        animateToPage: false,
                        animateToUser: true,
                      );
                    } else {
                      // !  finsh User Story
                      Navigator.pop(context);
                    }
                  }
                });
              } else {
                // if (users![initialpage].storys![_currentIndex].media ==
                //     MediaType.video) {
                //   if (_videoController!.value.isPlaying) {
                //     _videoController!.pause();
                //     _animController!.stop();
                //   } else {
                //     _videoController!.play();
                //     _animController!.forward();
                //   }
                // }
              }
            },
            // onTapDown: (details) => _onTapDown(details, story),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                PageView.builder(
                  controller: _pageController2,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: user.story!.length,
                  itemBuilder: (context, indexStory) {
                    Story story = user.story![indexStory];
                    switch (story.dateType!) {
                      case Photo:
                        // return FutureBuilder(
                        //   future: getUrlResponse(
                        //     story.url!,
                        //   ),
                        //   builder: (BuildContext context,
                        //       AsyncSnapshot<http.Response> snapshot) {
                        //     switch (snapshot.connectionState) {
                        //       case ConnectionState.none:
                        //       case ConnectionState.waiting:
                        //         return const Center(
                        //             child: CircularProgressIndicator());
                        //       case ConnectionState.active:
                        //       case ConnectionState.done:
                        //         if (snapshot.hasError) {
                        //           return const Center(
                        //             child: Text('Error appear!'),
                        //           );
                        //         }
                        //         if (!snapshot.hasData) {
                        //           return const Center(
                        //             child: Text('Error appear!'),
                        //           );
                        //         }
                        //         _animController!.forward();
                        //         return Image.memory(
                        //           snapshot.data!.bodyBytes,
                        //           fit: BoxFit.cover,
                        //         );
                        //     }
                        //     return Container();
                        //   },
                        // );
                        _animController!.stop();
                        return Image.network(
                          "$HOST/$STORYIMAGE/${story.photo!}",
                          fit: BoxFit.cover,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            if (frame == null) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              _animController!.forward();
                              return child;
                            }
                          },
                          // loadingBuilder: (context, child,
                          //     ImageChunkEvent? loadingProgress) {
                          //   if (loadingProgress == null) {
                          //     return child;
                          //   } else {
                          //     return Center(
                          //       child: CircularProgressIndicator(
                          //         value: loadingProgress.expectedTotalBytes !=
                          //                 null
                          //             ? loadingProgress.cumulativeBytesLoaded /
                          //                 loadingProgress.expectedTotalBytes!
                          //             : null,
                          //       ),
                          //     );
                          //   }
                          // },
                        );
                      case Video:
                        if (_videoController != null &&
                            _videoController!.value.isInitialized) {
                          return FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController!.value.size.width,
                              height: _videoController!.value.size.height,
                              child: VideoPlayer(_videoController!),
                            ),
                          );
                        }
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Positioned(
                  top: 40.0,
                  left: 10.0,
                  right: 10.0,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: widget.users![initialpage].story!
                            .asMap()
                            .map((i, e) {
                              return MapEntry(
                                i,
                                AnimatedBar(
                                  animController: _animController!,
                                  position: i,
                                  currentIndex: _currentIndex,
                                ),
                              );
                            })
                            .values
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 1.5,
                          vertical: 10.0,
                        ),
                        child: StoryUserInfo(
                          creatAt: widget.users![initialpage]
                              .story![_currentIndex].createdAt,
                          name: widget.users![initialpage].name,
                          profileImageUrl:
                              widget.users![initialpage].photo != null
                                  ? widget.users![initialpage].photo
                                  : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ), // return PageView(
    );
  }

  void _loadStory(
      {Story? story, bool animateToPage = true, bool animateToUser = false}) {
    _animController!.stop();
    _animController!.reset();
    switch (story!.dateType) {
      case Photo:
        _animController!.duration = const Duration(seconds: 10);
        // _animController!.forward();

        break;
      case Video:
        _videoController = null;
        _videoController?.dispose();
        _videoController = VideoPlayerController.network(
          "$HOST/$STORYVIDEO/${story.photo!}",
        )..initialize().then((_) {
            setState(() {});
            if (_videoController!.value.isInitialized) {
              _animController!.duration = _videoController!.value.duration;
              _videoController!.play();
              _animController!.forward();
            }
          });
        break;
    }
    if (animateToPage) {
      _pageController2!.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
      _pageController = PageController(
        initialPage: initialpage,
      );

      _pageController2 = PageController(
        initialPage: _currentIndex,
      );
    }
    if (animateToUser) {
      _pageController!.animateToPage(
        initialpage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
      _pageController = PageController(
        initialPage: initialpage,
      );

      _pageController2 = PageController(
        initialPage: _currentIndex,
      );
    }
  }
}
