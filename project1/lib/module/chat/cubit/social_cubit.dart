import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/models/chat/message_model.dart';
import 'package:project1/models/chat/user_message_model.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';

// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'social_state.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  // SocialUserModel? userModel;

// ! Get User Data
  // void getUserData() {
  //   emit(SocialGetUserLoadingStates());
  //   FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
  //     userModel = SocialUserModel.fromJson(value.data());
  //     emit(SocialGetUserSuccessStates());
  //   }).catchError((e) {
  //     emit(SocialGetUserErrorStates(e.toString()));
  //   });
  // }

// ! Image  profile

  // final ImagePicker picker = ImagePicker();

  // // * Get image picker for profile Image
  // File? profileImage;
  // Future<void> getProfileImage() async {
  //   final XFile? pickedFile =
  //       await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     profileImage = File(pickedFile.path);
  //     emit(SocialProfileImagePickedSuccessStates());
  //   } else {
  //     print('No Image selected');
  //     emit(SocialProfileImagePickedErrorStates());
  //   }
  // }

  // //? Upload Data with Profile image
  // void uploadProfileImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUploadLoadingStates());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
  //       .putFile(profileImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       // emit(SocialUploadProfileImageSuccessStates());
  //       updateUser(name: name, phone: phone, bio: bio, image: value);
  //     }).catchError((onError) {
  //       emit(SocialUploadProfileImageErrorStates());
  //     });
  //   }).catchError((onError) {
  //     emit(SocialUploadProfileImageErrorStates());
  //   });
  // }

  // // *Get image picker for Cover Image
  // File? coverImage;
  // Future<void> getCoverImage() async {
  //   final XFile? pickedFile =
  //       await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     coverImage = File(pickedFile.path);
  //     emit(SocialCoverImagePickedSuccessStates());
  //   } else {
  //     print('No Image selected');
  //     emit(SocialCoverImagePickedErrorStates());
  //   }
  // }

  // //? Upload Data  with Cover image
  // void uploadCoverImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUploadLoadingStates());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
  //       .putFile(coverImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       //  emit(SocialUploadCoverImageSuccessStates());

  //       updateUser(name: name, phone: phone, bio: bio, cover: value);
  //     }).catchError((onError) {
  //       emit(SocialUploadCoverImageErrorStates());
  //     });
  //   }).catchError((onError) {
  //     emit(SocialUploadCoverImageErrorStates());
  //   });
  // }

  // // ? Upload All Data
  // void updateUser({
  //   required String name,
  //   required String phone,
  //   required String bio,
  //   String? cover,
  //   String? image,
  // }) {
  //   SocialUserModel model = SocialUserModel(
  //     name: name,
  //     phone: phone,
  //     bio: bio,
  //     email: userModel!.email,
  //     cover: cover ?? userModel!.cover,
  //     image: image ?? userModel!.image,
  //     uId: userModel!.uId,
  //     isEmailVerified: false,
  //   );
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .update(model.toMap())
  //       .then((value) {
  //     getUserData();
  //   }).catchError((e) {
  //     emit(SocialUserUploadErrorStates());
  //   });
  // }

  // // !Get All Users
  // List<SocialUserModel>? users = [];
  // void getAllUsers() {
  //   users = [];
  //   FirebaseFirestore.instance.collection('users').get().then((value) {
  //     for (var element in value.docs) {
  //       if (element.data()['uId'] != userModel!.uId) {
  //         users!.add(SocialUserModel.fromJson(element.data()));
  //       }
  //     }
  //     emit(SocialGetAllUserSuccessStates());
  //   }).catchError((e) {
  //     emit(SocialGetAllUserErrorStates(e.toString()));
  //   });
  // }

  //!Send Notification

  // void sendNotification({
  //   required String? topicUid,
  //   required String? text,
  //   required String? sender,
  //   required SocialUserModel? resever,
  // }) {
  //   NotificationModel model = NotificationModel(
  //     to: "/topics/$topicUid",
  //     data: Data(
  //       text: text,
  //       sender: userModel!.name,
  //       resever: resever,
  //     ),
  //   );
  //   DioHelper.postData(data: model.toJson()).then((value) {
  //     print(value);
  //   }).catchError((e) {});
  // }

  // UserMessageModel

  // void userCreate({
  //   required int senderUserId,
  //   required String senderUserName,
  //   required String senderUserPhoto,
  //   required int reseverUserId,
  //   required String reseverUserName,
  //   required String reseverUserPhoto,
  // }) async {
  //   emit(SocialCreateUserLoadingState());
  //   UserMessageModel modelSernder = UserMessageModel(
  //     userId: senderUserId,
  //     userName: senderUserName,
  //     userPhoto: senderUserPhoto,
  //   );
  //   UserMessageModel modelResever = UserMessageModel(
  //     userId: reseverUserId,
  //     userName: senderUserName,
  //     userPhoto: senderUserPhoto,
  //   );
  //   await FirebaseFirestore.instance
  //       .collection('user_chats')
  //       .doc(1.toString())
  //       .set(modelSernder.toMap())
  //       .then((value) {
  //     emit(SocialCreateUserSccessState());
  //   }).catchError((e) {
  //     print(e.toString());
  //     emit(SocialCreateUserErrorState(e.toString()));
  //   });
  // }

  List<UserMessageModel>? userReseverModel = [];

  void getAllUserResver() {
    emit(SocialGetUserLoadingStates());
    userReseverModel = [];
    FirebaseFirestore.instance
        .collection('user_chats')
        .doc(CacheHelper.getData(key: USERID).toString())
        .collection('chats')
        .get()
        .then((value) {
      for (var element in value.docs) {
        userReseverModel!.add(UserMessageModel.fromJson(element.data()));
      }
      emit(SocialGetUserSuccessStates());
    }).catchError((e) {
      emit(SocialGetUserErrorStates(e.toString()));
    });
  }

  // //!Messages
  void sendMessage({
    required int? receiverId,
    required int? senderId,
    required String? dateTime,
    required String? text,
    //
    required String? receiverName,
    required String? receiverPhoto,
    required String? senderName,
    required String? senderPhoto,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      dateTime: dateTime,
      senderId: senderId,
      text: text,
    );
    //? set my chat
    FirebaseFirestore.instance
        .collection('user_chats')
        .doc(senderId.toString())
        // .delete()
        .collection('chats')
        .doc(receiverId.toString())
        .collection('messages')
        .add(model.toMap())
        .then((value) async {
      userStorge(
        firstId: senderId,
        secandId: receiverId,
        dateTime: dateTime,
        text: text,
        userStorgeName: receiverName,
        userStorgePhoto: receiverPhoto,
      );

      emit(SocialSendMessageSuccessStates());
    }).catchError((e) {
      emit(SocialSendMessageErrorStates());
    });

    //? set receiver chat
    FirebaseFirestore.instance
        .collection('user_chats')
        .doc(receiverId.toString())
        // .delete()
        .collection('chats')
        .doc(senderId.toString())
        .collection('messages')
        .add(model.toMap())
        .then((value) async {
      userStorge(
        firstId: receiverId,
        secandId: senderId,
        dateTime: dateTime,
        text: text,
        userStorgeName: senderName,
        userStorgePhoto: senderPhoto,
      );

      emit(SocialSendMessageSuccessStates());
    }).catchError((e) {
      emit(SocialSendMessageErrorStates());
    });
  }

  void userStorge({
    required int? firstId,
    required int? secandId,
    required String? dateTime,
    required String? text,
    required String? userStorgeName,
    required String? userStorgePhoto,
  }) {
    emit(SocialCreateandUpdateUserLoadingState());
    UserMessageModel modelStorge = UserMessageModel(
      userId: secandId,
      userName: userStorgeName,
      userPhoto: userStorgePhoto,
      dateTimeLastMessage: dateTime,
      lastMessage: text,
    );
    FirebaseFirestore.instance
        .collection('user_chats')
        .doc(firstId.toString())
        .collection('chats')
        .doc(secandId.toString())
        .get()
        .then((value) {
      if (!value.exists) {
        FirebaseFirestore.instance
            .collection('user_chats')
            .doc(firstId.toString())
            .collection('chats')
            .doc(secandId.toString())
            .set(modelStorge.toMap())
            .then((value) {
          emit(SocialCreateandUpdateUserSccessState());
        }).catchError((e) {
          emit(SocialCreateandUpdateUserErrorState(e));
        });
      } else {
        FirebaseFirestore.instance
            .collection('user_chats')
            .doc(firstId.toString())
            .collection('chats')
            .doc(secandId.toString())
            .update(modelStorge.toMap())
            .then((value) {
          emit(SocialCreateandUpdateUserSccessState());
        }).catchError((e) {
          emit(SocialCreateandUpdateUserErrorState(e));
        });
      }
      // if (element.data()['uId'] != userModel!.uId) {
      //   users!.add(SocialUserModel.fromJson(element.data()));
      // }
      // }
    });

    //   emit(SocialCreateUserSccessState());
    // }).catchError((e) {
    //   print(e.toString());
    //   emit(SocialCreateUserErrorState(e));
    // });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required int? receiverId,
    required int? senderId,
  }) {
    messages = [];
    FirebaseFirestore.instance
        .collection('user_chats')
        .doc(senderId.toString())
        .collection('chats')
        .doc(receiverId.toString())
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages.add(MessageModel.fromJson(event.docs.reversed.last.data()));
      // for (var element in event.docs.reversed) {
      //   messages.add(MessageModel.fromJson(element.data()));
      // }
      emit(SocialGetMessageSuccessStates());
    });
  }
}
