import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/module/add_photo/add_photo_register_screen.dart';

import 'package:project1/module/add_post/gallery_add_post_screen.dart';
import 'package:project1/module/edit_profile/edit_photo_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';

// import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  List<CameraDescription>? cameras;
  String? tikePictureNavigator;
  CameraScreen({required this.cameras, required this.tikePictureNavigator});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;

  // Initial values
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = true;
  bool _isRearCameraSelected = true;

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
// !
  // getPermissionStatus() async {
  //   await Permission.camera.request();
  //   var status = await Permission.camera.status;

  //   if (status.isGranted) {
  //     log('Camera Permission: GRANTED');
  //     setState(() {
  //       _isCameraPermissionGranted = true;
  //     });
  //     // Set and initialize the new camera
  //     onNewCameraSelected(cameras[0]);
  //   } else {
  //     log('Camera Permission: DENIED');
  //   }
  // }

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

  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
    _currentExposureOffset = 0.0;
  }

// !
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    resetCameraValues();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // getPermissionStatus();
    onNewCameraSelected(widget.cameras![0]);
    super.initState();
  }

// !
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body:
            // _isCameraPermissionGranted
            // ?
            _isCameraInitialized
                ? Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / controller!.value.aspectRatio,
                        child: CameraPreview(
                          controller!,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTapDown: (details) =>
                                    onViewFinderTap(details, constraints),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            getProportionateScreenWidth(16),
                            getProportionateScreenHeight(8),
                            getProportionateScreenWidth(16),
                            getProportionateScreenHeight(8.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(8.0),
                                      right: getProportionateScreenWidth(8.0)),
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
                              padding: EdgeInsets.only(
                                  right: getProportionateScreenWidth(8.0),
                                  top: getProportionateScreenHeight(16.0)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(8),
                                    vertical: getProportionateScreenHeight(8),
                                  ),
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
                                  height: getProportionateScreenHeight(30),
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
                                  padding: EdgeInsets.only(
                                      right: getProportionateScreenWidth(8.0)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getProportionateScreenWidth(8),
                                          vertical:
                                              getProportionateScreenHeight(8)),
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
                              padding: EdgeInsets.fromLTRB(
                                  getProportionateScreenWidth(16),
                                  getProportionateScreenHeight(8),
                                  getProportionateScreenWidth(16),
                                  getProportionateScreenHeight(8.0)),
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
                                      Icons.cameraswitch_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    takePicture().then((value) {
                                      if (widget.tikePictureNavigator ==
                                          'addpost') {
                                        Navigator.pop(context);
                                        navigateAndReplac(
                                          context,
                                          GalleryAddPostScreen(
                                            image: File(value!.path),
                                          ),
                                        );
                                      }
                                      if (widget.tikePictureNavigator ==
                                          'addphoto') {
                                        Navigator.pop(context);
                                        navigateAndReplac(
                                          context,
                                          AddPhotoRegisterScreen(
                                            image: File(value!.path),
                                          ),
                                        );
                                      }
                                      if (widget.tikePictureNavigator ==
                                          'updatephoto') {
                                        Navigator.pop(context);
                                        navigateAndReplac(
                                          context,
                                          EditPhotoScreen(
                                            image: File(value!.path),
                                          ),
                                        );
                                      }

                                      if (widget.tikePictureNavigator ==
                                          'editpost') {}
                                    }).catchError((e) {});
                                    // File imageFile = File(rawImage!.path);
                                    // int currentUnix = DateTime.now()
                                    //     .millisecondsSinceEpoch;
                                    // final directory =
                                    //     await getApplicationDocumentsDirectory();
                                    // String fileFormat =
                                    //     imageFile.path.split('.').last;
                                    // print(fileFormat);
                                    // await imageFile.copy(
                                    //   '${directory.path}/$currentUnix.$fileFormat',
                                    // );
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
                                      Container(),
                                    ],
                                  ),
                                ),
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

        //  :Column(
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
        //           // getPermissionStatus();
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
