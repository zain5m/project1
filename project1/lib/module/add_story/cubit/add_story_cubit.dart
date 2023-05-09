import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';

part 'add_story_state.dart';

class FirstImagesFromAllAlbumAndName {
  AssetPathEntity? album;
  AssetEntity? image;

  FirstImagesFromAllAlbumAndName({this.album, this.image});
}

class AddStoryCubit extends Cubit<AddStoryStates> {
  AddStoryCubit() : super(AddStoryInitialState());
  static AddStoryCubit get(context) => BlocProvider.of(context);

  List<AssetPathEntity>? albums = [];
  AssetPathEntity? currentAlbum;
  List<AssetEntity>? imagesFromAlbum = [];

  List<FirstImagesFromAllAlbumAndName>? firstImagesFromAllAlbumAndName = [];

  void getAlbums() {
    emit(AddStoryGetAlbumsInitialState());
    PhotoManager.getAssetPathList().then((value) {
      // !get All Albums
      albums = value;

      // !Get Current Album
      currentAlbum = albums![0];
      // ! Get All Images from Album

      getFirstImagesFromAllAlbum();
      getAllImagesFromAlbum();

      emit(AddStoryGetAlbumsSucssesState());
    }).catchError((e) {
      emit(AddStoryGetAlbumsErorrState());
    });
  }

  void getNewCurrentAlbum({AssetPathEntity? albumNew}) {
    emit(AddStoryGetNewCurrentAlbumInitialState());
    currentAlbum = albumNew;
    getAllImagesFromAlbum();
    emit(AddStoryGetNewCurrentAlbumState());
  }

  void getFirstImagesFromAllAlbum() {
    emit(AddStoryGetFirstImagesFromAllAlbumInitialState());

    firstImagesFromAllAlbumAndName = [];
    for (int index = 0; index < albums!.length; index++) {
      albums![index].getAssetListRange(start: 0, end: 1).then((value) {
        firstImagesFromAllAlbumAndName!.add(FirstImagesFromAllAlbumAndName(
          image: value.first,
          album: albums![index],
        ));

        emit(AddStoryGetFirstImagesFromAllAlbumSucssesState());
      }).catchError((e) {
        emit(AddStoryGetFirstImagesFromAllAlbumErorrState());
      });
    }
  }

  void getAllImagesFromAlbum() {
    emit(AddStoryGetAllImagesFromAlbumInitialState());
    imagesFromAlbum = [];
    imagesFromAlbum!
        .add(AssetEntity(id: 'id', typeInt: 1, width: 1, height: 1));

    currentAlbum!
        .getAssetListRange(
      start: 0,
      end: 1000000,
    )
        .then((value) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].type.name == AssetType.video.name) {
          imagesFromAlbum!.add(value[i]);
        }
        if (value[i].type.name == AssetType.image.name) {
          imagesFromAlbum!.add(value[i]);
        }
      }
      emit(AddStoryGetAllImagesFromAlbumSucssesState());
    }).catchError((onError) {
      emit(AddStoryGetAllImagesFromAlbumErorrState());
    });
  }

  final token = CacheHelper.getData(key: TOKEN);

  void postStory({
    required File? story,
    required String? type,
  }) async {
    emit(AddStoryPostInitialState());
    String fileName = story!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(story.path, filename: fileName),
      "date_type": type,
    });
    DioHelper.postData(
      url: ADDSTORY,
      token: token,
      data: formData,
    ).then((response) {
      if (response.statusCode == 200) {
        emit(AddStoryPostSucssesState());
      } else if (response.statusCode! >= 500) {
        emit(AddStoryPostErorrState("Error on server"));
      } else {
        emit(AddStoryPostErorrState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
      emit(AddStoryPostErorrState("Error on add Story"));
    });
  }
}
