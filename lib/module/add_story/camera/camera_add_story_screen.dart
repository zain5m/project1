import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/module/add_story/preview/image_screen_add_story.dart';
import 'package:project1/module/add_story/preview/video_screen_add_story.dart';
import 'package:project1/shared/components/components.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class CameraAddStoryScreen extends StatefulWidget {
  List<CameraDescription>? cameras;
  CameraAddStoryScreen({this.cameras});

  @override
  _CameraAddStoryScreenState createState() => _CameraAddStoryScreenState();
}

class _CameraAddStoryScreenState extends State<CameraAddStoryScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  VideoPlayerController? videoController;

  File? _imageFile;
  File? _videoFile;

  // Initial values
  bool _isCameraInitialized = false;
  // bool _isCameraPermissionGranted = false;
  bool _isRearCameraSelected = true;
  // bool _isVideoCameraSelected = true;
  bool _isRecordingInProgress = false;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  // Current values
  double _currentZoomLevel = 1.0;
  double _currentExposureOffset = 0.0;
  FlashMode? _currentFlashMode;

  List<File> allFileList = [];

  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  // getPermissionStatus() async {
  //   await Permission.camera.request();
  //   var status = await Permission.camera.status;

// !
  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  Future<void> _startVideoPlayer() async {
    if (_videoFile != null) {
      videoController = VideoPlayerController.file(_videoFile!);
      await videoController!.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
      await videoController!.setLooping(true);
      await videoController!.play();
    }
  }

// !
  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (controller!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }

    try {
      await cameraController!.startVideoRecording();

      setState(() {
        _isRecordingInProgress = true;
        print(_isRecordingInProgress);
      });
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
    }
  }

// !
  Future<XFile?> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }

    try {
      XFile file = await controller!.stopVideoRecording();
      // var dr= Duration(
      //     seconds: 15,
      //   );

      setState(() {
        _isRecordingInProgress = false;
      });
      return file;
    } on CameraException catch (e) {
      print('Error stopping video recording: $e');
      return null;
    }
  }

// !
  Future<void> pauseVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }

    try {
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error pausing video recording: $e');
    }
  }

// !
  Future<void> resumeVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // No video recording was in progress
      return;
    }

    try {
      await controller!.resumeVideoRecording();
    } on CameraException catch (e) {
      print('Error resuming video recording: $e');
    }
  }

// !
  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
    _currentExposureOffset = 0.0;
  }

// !
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    // final previousCameraController = controller;
    final CameraController? oldController = controller;

    if (oldController != null) {
      // `controller` needs to be set to null before getting disposed,
      // to avoid a race condition when we use the controller that is being
      // disposed. This happens when camera permission dialog shows up,
      // which triggers `didChangeAppLifecycleState`, which disposes and
      // re-creates the controller.
      controller = null;
      await oldController.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    resetCameraValues();
    controller = cameraController;
    // await previousCameraController?.dispose();
    // if (mounted) {
    //   setState(() {
    //     controller = cameraController;
    //   });
    // }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          validatorSnackBarInterests(
              state: ToastState.ERROR,
              text: 'Camera error ${cameraController.value.errorDescription}'),
        );
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController
            .getMinExposureOffset()
            .then((value) => _minAvailableExposureOffset = value),
        cameraController
            .getMaxExposureOffset()
            .then((value) => _maxAvailableExposureOffset = value),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);

      _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

// !
  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

// !
  @override
  void initState() {
    // Hide the status bar in Android
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    onNewCameraSelected(widget.cameras![0]);
    // getPermissionStatus();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

// !
  @override
  void dispose() {
    controller?.dispose();
    videoController?.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body:
            // ?_isCameraPermissionGranted
            _isCameraInitialized
                ? Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / controller!.value.aspectRatio,
                        child: CameraPreview(
                          controller!,
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTapDown: (details) =>
                                  onViewFinderTap(details, constraints),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // !DropdownButton
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: DropdownButton<ResolutionPreset>(
                                    dropdownColor: Colors.black87,
                                    underline: Container(),
                                    value: currentResolutionPreset,
                                    items: [
                                      for (ResolutionPreset preset
                                          in resolutionPresets)
                                        DropdownMenuItem(
                                          child: Text(
                                            preset
                                                .toString()
                                                .split('.')[1]
                                                .toUpperCase(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: preset,
                                        )
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        currentResolutionPreset = value!;
                                        _isCameraInitialized = false;
                                      });
                                      onNewCameraSelected(
                                          controller!.description);
                                    },
                                    hint: Text("Select item"),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _currentExposureOffset.toStringAsFixed(1) +
                                        'x',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Container(
                                  height: 30,
                                  child: Slider(
                                    value: _currentExposureOffset,
                                    min: _minAvailableExposureOffset,
                                    max: _maxAvailableExposureOffset,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white30,
                                    onChanged: (value) async {
                                      setState(() {
                                        _currentExposureOffset = value;
                                      });
                                      await controller!
                                          .setExposureOffset(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value: _currentZoomLevel,
                                    min: _minAvailableZoom,
                                    max: _maxAvailableZoom,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white30,
                                    onChanged: (value) async {
                                      setState(() {
                                        _currentZoomLevel = value;
                                      });
                                      await controller!.setZoomLevel(value);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _currentZoomLevel.toStringAsFixed(1) +
                                            'x',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 8.0, 16.0, 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _currentFlashMode = FlashMode.off;
                                      });
                                      await controller!.setFlashMode(
                                        FlashMode.off,
                                      );
                                    },
                                    child: Icon(
                                      Icons.flash_off,
                                      size: 20,
                                      color: _currentFlashMode == FlashMode.off
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _currentFlashMode = FlashMode.auto;
                                      });
                                      await controller!.setFlashMode(
                                        FlashMode.auto,
                                      );
                                    },
                                    child: Icon(
                                      Icons.flash_auto,
                                      size: 20,
                                      color: _currentFlashMode == FlashMode.auto
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _currentFlashMode = FlashMode.always;
                                      });
                                      await controller!.setFlashMode(
                                        FlashMode.always,
                                      );
                                    },
                                    child: Icon(
                                      Icons.flash_on,
                                      size: 20,
                                      color:
                                          _currentFlashMode == FlashMode.always
                                              ? Colors.amber
                                              : Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _currentFlashMode = FlashMode.torch;
                                      });
                                      await controller!.setFlashMode(
                                        FlashMode.torch,
                                      );
                                    },
                                    child: Icon(
                                      Icons.highlight,
                                      size: 20,
                                      color:
                                          _currentFlashMode == FlashMode.torch
                                              ? Colors.amber
                                              : Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _isCameraInitialized = false;
                                      });
                                      onNewCameraSelected(widget.cameras![
                                          _isRearCameraSelected ? 1 : 0]);
                                      setState(() {
                                        _isRearCameraSelected =
                                            !_isRearCameraSelected;
                                      });
                                    },
                                    child: Icon(
                                      // _isRearCameraSelected
                                      // ?
                                      Icons.cameraswitch_outlined,
                                      // : Icons.flip_camera_android_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(flex: 3),
                                InkWell(
                                  onTap: () async {
                                    if (_isRecordingInProgress) {
                                      if (controller!.value.isRecordingPaused) {
                                        await resumeVideoRecording();
                                      } else {
                                        await pauseVideoRecording();
                                      }
                                    } else {
                                      await startVideoRecording();
                                    }
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.white38,
                                        size: 50,
                                      ),
                                      !_isRecordingInProgress
                                          ? Icon(
                                              Icons.circle,
                                              color: Colors.red,
                                            )
                                          : Container(),
                                      _isRecordingInProgress
                                          ? controller!.value.isRecordingPaused
                                              ? Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.pause,
                                                  color: Colors.white,
                                                )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Spacer(flex: 3),
                                InkWell(
                                  onTap: _isRecordingInProgress
                                      ? () async {
                                          stopVideoRecording().then((value) {
                                            navigateAndReplac(
                                              context,
                                              VideoScreenAddStory(
                                                videoFile: File(value!.path),
                                              ),
                                            );
                                          }).catchError((w) {});
                                        }
                                      : () async {
                                          takePicture().then((value) {
                                            navigateAndReplac(
                                              context,
                                              ImageScreenAddStory(
                                                imageFile: File(value!.path),
                                              ),
                                            );
                                          }).catchError((w) {});
                                        },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.white38,
                                        size: 80,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: Colors.white,
                                        size: 65,
                                      ),
                                      _isRecordingInProgress
                                          ? Icon(
                                              Icons.stop_rounded,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Spacer(flex: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'LOADING',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

        // : Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Row(),
        //       Text(
        //         'Permission denied',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 24,
        //         ),
        //       ),
        //       SizedBox(height: 24),
        //       ElevatedButton(
        //         onPressed: () {
        //           getPermissionStatus();
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(
        //             'Give permission',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 24,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
      ),
    );
  }
}
