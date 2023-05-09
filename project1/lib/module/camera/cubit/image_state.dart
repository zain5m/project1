part of 'image_cubit.dart';

@immutable
abstract class ImageStates {}

class ImageInitialState extends ImageStates {}

class ImageChangeIsPhotoState extends ImageStates {}

//! Get Albubs
class ImageGetAlbumsInitialState extends ImageStates {}

class ImageGetAlbumsSucssesState extends ImageStates {
  bool?  isGetAlbumsSucsses =false;
  ImageGetAlbumsSucssesState({this.isGetAlbumsSucsses});
}

class ImageGetAlbumsErorrState extends ImageStates {}

// ! Get All Imges From Albums
class ImageGetAllImagesFromAlbumInitialState extends ImageStates {}

class ImageGetAllImagesFromAlbumSucssesState extends ImageStates {}

class ImageGetAllImagesFromAlbumErorrState extends ImageStates {}

// ! Get Current Image
class ImageGetCurrentImageInitialState extends ImageStates {}

class ImageGetCurrentImageSucssesState extends ImageStates {
  bool ? isCurrentImageSucsses=false;
  ImageGetCurrentImageSucssesState({this.isCurrentImageSucsses});
}

class ImageGetcurrentImageErorrState extends ImageStates {}

// ! Get Current Drop Down Value
class ImageCurrentdropdownValueInitialState extends ImageStates {}

class ImageCurrentdropdownValueState extends ImageStates {}
