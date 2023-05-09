part of 'add_story_cubit.dart';

@immutable
abstract class AddStoryStates {}

class AddStoryInitialState extends AddStoryStates {}

//! Get Albubs
class AddStoryGetAlbumsInitialState extends AddStoryStates {}

class AddStoryGetAlbumsSucssesState extends AddStoryStates {}

class AddStoryGetAlbumsErorrState extends AddStoryStates {}

// ! Get First Images From All Album
class AddStoryGetFirstImagesFromAllAlbumInitialState extends AddStoryStates {}

class AddStoryGetFirstImagesFromAllAlbumSucssesState extends AddStoryStates {}

class AddStoryGetFirstImagesFromAllAlbumErorrState extends AddStoryStates {}

// ! Get All Imges From Albums
class AddStoryGetAllImagesFromAlbumInitialState extends AddStoryStates {}

class AddStoryGetAllImagesFromAlbumSucssesState extends AddStoryStates {}

class AddStoryGetAllImagesFromAlbumErorrState extends AddStoryStates {}

// ! Get First Image
class AddStoryGetFirstimageFromAlbumInitialState extends AddStoryStates {}

class AddStoryGetFirstimageFromAlbumSucssesState extends AddStoryStates {}

class AddStoryGetFirstimageFromAlbumErorrState extends AddStoryStates {}

// ! Get Get New Current Album
class AddStoryGetNewCurrentAlbumInitialState extends AddStoryStates {}

class AddStoryGetNewCurrentAlbumState extends AddStoryStates {}

// ! Get First Image
class AddStoryPostInitialState extends AddStoryStates {}

class AddStoryPostSucssesState extends AddStoryStates {}

class AddStoryPostErorrState extends AddStoryStates {
  String error;
  AddStoryPostErorrState(this.error);
}
