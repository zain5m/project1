part of 'edit_post_cubit.dart';

@immutable
abstract class EditPostStates {}

class EditPostInitialState extends EditPostStates {}

class EditPostChangeShowIntersteState extends EditPostStates {}

class EditPostChangeInterstsSelectedState extends EditPostStates {}

class EditPostImagePickedSuccessStates extends EditPostStates {}

class EditPostImagePickedErrorStates extends EditPostStates {}

class EditPostDeleteImagePickedSuccessStates extends EditPostStates {}
