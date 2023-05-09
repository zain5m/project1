import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:photo_manager/photo_manager.dart';
import 'package:project1/module/add_story/camera/camera_add_story_screen.dart';
import 'package:project1/module/add_story/components/components.dart';
import 'package:project1/module/add_story/cubit/add_story_cubit.dart';
import 'package:project1/module/add_story/gallery/asset_thumbnail_add_story.dart';
import 'package:project1/module/add_story/preview/image_screen_add_story.dart';
import 'package:project1/module/add_story/preview/video_screen_add_story.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

class GalleryAddStoryScreen extends StatefulWidget {
  List<CameraDescription>? cameras;
  GalleryAddStoryScreen({this.cameras});

  @override
  State<GalleryAddStoryScreen> createState() => _GalleryAddStoryScreenState();
}

class _GalleryAddStoryScreenState extends State<GalleryAddStoryScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  GlobalKey keyForBack = GlobalKey<ScaffoldState>();
  GlobalKey keyAppBar = GlobalKey();

  CameraController? controller;

  bool _isCameraInitialized = false;

  @override
  void initState() {
    onNewCameraSelected(widget.cameras![0]);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    controller!.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = controller;
    if (oldController != null) {
      controller = null;
      await oldController.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low,
    );
    controller = cameraController;
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
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStoryCubit()..getAlbums(),
      child: BlocConsumer<AddStoryCubit, AddStoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AddStoryCubit cubit = AddStoryCubit.get(context);
          return Scaffold(
            key: keyForBack,
            appBar: AppBar(
              key: keyAppBar,
              backgroundColor: Colors.white,
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
                Icon(
                  Icons.auto_awesome_motion,
                  color: defaultColor,
                  size: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    child: Text(
                      cubit.currentAlbum != null
                          ? cubit.currentAlbum!.name
                          : '',
                      style: TextStyle(
                        fontSize: 18,
                        color: defaultColor,
                      ),
                    ),
                    onPressed: () {
                      final keyContext = keyAppBar.currentContext;
                      final box = keyContext!.findRenderObject() as RenderBox;
                      final pos = box.localToGlobal(Offset.zero);

                      showModalBottomSheet(
                        isScrollControlled: true,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return albumBottomSheet(
                            cubit: cubit,
                            height: MediaQuery.of(context).size.height -
                                box.size.height,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            body: Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: getProportionateScreenHeight(240),
                ),
                itemCount: cubit.imagesFromAlbum!.isEmpty
                    ? 1
                    : cubit.imagesFromAlbum!.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _isCameraInitialized
                        ? cameraGallery(
                            context: context,
                            cameras: widget.cameras,
                            controller: controller,
                          )
                        : Container();
                  } else {
                    return AssetThumbnailAddStory(
                      asset: cubit.imagesFromAlbum![index],
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
