import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageStates> {
  ImageCubit() : super(ImageInitialState());

  ImageCubit get(context) => BlocProvider.of(context);
  List<AssetPathEntity>? albums = [];
  List<String>? nameAlbums = [];
  String? currentdropdownValue;
  int? currentIndexAlbum = 0;
  AssetPathEntity? currentAlbum;
  List<AssetEntity>? imageFromAlbum = [];
  File? currentImage;
  bool isphoto = false;

  void changeIsPhoto(bool b) {
    isphoto = b;
    emit(ImageChangeIsPhotoState());
  }

  void getAlbums({File? image}) {
    emit(ImageGetAlbumsInitialState());
    PhotoManager.getAssetPathList().then((value) {
      // !get All Albums
      albums = value;
      if (value.isNotEmpty) {
        currentdropdownValue = albums!.first.name;
        // !get List All Albums Name
        for (int i = 0; i < albums!.length; i++) {
          if (nameAlbums!.contains(albums![i].name)) {
            nameAlbums!.add("$i${albums![i].name}");
          } else {
            nameAlbums!.add(albums![i].name);
          }
        }
        // !Get Current Album
        currentAlbum = albums![currentIndexAlbum!];
        emit(ImageGetAlbumsSucssesState());
        // ! Get All Images from Album
        getAllImagesFromAlbum(image: image);
      } else if (value.isEmpty && image != null) {
        emit(ImageGetAlbumsSucssesState());
        getCurrentImage(newImage: image);
      } else {
        emit(ImageGetAlbumsSucssesState());
        emit(ImageGetCurrentImageSucssesState());
      }
    }).catchError((e) {
      emit(ImageGetAlbumsErorrState());
    });
  }

  void getdropdownValue(String? albumName) {
    emit(ImageCurrentdropdownValueInitialState());
    currentdropdownValue = albumName!;
    currentIndexAlbum = nameAlbums!.indexOf(albumName);
    currentAlbum = albums![currentIndexAlbum!];
    emit(ImageCurrentdropdownValueState());
    getAllImagesFromAlbum();
  }

  void getAllImagesFromAlbum({File? image}) {
    emit(ImageGetAllImagesFromAlbumInitialState());
    imageFromAlbum = [];
    currentAlbum!
        .getAssetListRange(
      start: 0,
      end: 1000000,
    )
        .then((value) {
      for (var element in value) {
        if (element.type.name == AssetType.image.name) {
          imageFromAlbum!.add(element);
        }
      }
      emit(ImageGetAllImagesFromAlbumSucssesState());
      getCurrentImage(newImage: image);
    }).catchError((onError) {
      emit(ImageGetAllImagesFromAlbumErorrState());
    });
  }

  void getCurrentImage({File? newImage}) {
    emit(ImageGetCurrentImageInitialState());
    if (newImage != null) {
      currentImage = newImage;
      emit(ImageGetCurrentImageSucssesState());
    } else {
      if (imageFromAlbum!.isEmpty) {
        currentImage = null;
        emit(ImageGetCurrentImageSucssesState());
      } else {
        imageFromAlbum!.first.file.then((file) {
          currentImage = file;
          emit(ImageGetCurrentImageSucssesState());
        }).catchError((e) {
          emit(ImageGetcurrentImageErorrState());
        });
      }
    }
  }
}
