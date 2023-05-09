import 'dart:developer';

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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserMessageModel>? userReseverModel = [];

//   void getAllUserResver({
//     required String myEmail,
//   }) {
//     emit(SocialGetUserLoadingStates());
// // !get All document in chat_Room
//     userReseverModel = [];

//     _firestore.collection('chat_Room').get().then(
//       (chatRoomDocs) {
//         log('message1 ${chatRoomDocs.size}');
//         // !chack is document contains myEmail
//         var myChatRoomDocs = chatRoomDocs.docs.where((element) {
//           return element.id.toString().startsWith(myEmail) ||
//               element.id.toString().endsWith(myEmail);
//         });
//         userReseverModel = [];
//         for (var myChatRoomDocId in myChatRoomDocs) {
//           // !get Email User Reseiver
//           var userReseiverDocId =
//               myChatRoomDocId.id.split(',').where((element) {
//             return element != myEmail;
//           });
//           //! get Info User Reseiver
//           _firestore.collection('user').doc(userReseiverDocId.first).snapshots()
//               // .asStream()
//               .listen((userReseverInfo) {
//             log('message2 ${userReseverInfo.data()}');

//             // userReseverModel = [];

//             //  })
//             // .get()
//             // .then((userReseverInfo) {
//             //! get messages not read in User Reseiver
//             _firestore
//                 .collection('chat_Room')
//                 .doc(myChatRoomDocId.id)
//                 .collection('messages')
//                 .where("isRead", isEqualTo: false)
//                 .snapshots()
//                 // .get()
//                 // .asStream()
//                 .listen((value) {
//               // })
//               // .then((value) {
//               var messagesNotRead = value.docs.where((element) {
//                 return element.data()['senderId'] !=
//                     CacheHelper.getData(key: USERID);
//               });
//               log('message3 ${messagesNotRead.length}');

//               userReseverModel!.add(UserMessageModel.fromJson(
//                 userReseverInfo.data(),
//                 myChatRoomDocId.data(),
//                 userReseiverDocId.first,
//                 messagesNotRead.length,
//               ));
//               emit(SocialGetUserSuccessStates());
//             });
//             // .catchError((e) {
//             //   print(e);
//             //   emit(SocialGetUserErrorStates(e.toString()));
//             // });
//           });
//           // .catchError((e) {
//           //   print(e);
//           //   emit(SocialGetUserErrorStates(e.toString()));
//           // });
//         }
//       },
//     );

//     // }).catchError((e) {
//     //   emit(SocialGetUserErrorStates(e.toString()));
//   }

  // //!Messages
  void sendMessage({
    required String roomId,
    required Timestamp dateTime,
    required String text,
    required int senderId,
    required int receiverId,
  }) {
    MessageModel model = MessageModel(
      text: text,
      timetoJson: dateTime,
      isRead: false,
      receiverId: 2,
      senderId: 1,
    );
    //? set my chat
    _firestore
        .collection('chat_Room')
        .doc(roomId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      lastmessageStorge(
        roomId: roomId,
        dateTime: dateTime,
        text: text,
      );

      emit(SocialSendMessageSuccessStates());
    }).catchError((e) {
      emit(SocialSendMessageErrorStates());
    });
  }

  void lastmessageStorge({
    required String? roomId,
    required Timestamp? dateTime,
    required String? text,
  }) {
    emit(SocialCreateandUpdateUserLoadingState());
    LastMessageModel modelLastMessage = LastMessageModel(
      timetoJson: dateTime,
      lastMessage: text,
    );
    _firestore.collection('chat_Room').doc(roomId).get().then((value) {
      if (!value.exists) {
        FirebaseFirestore.instance
            .collection('chat_Room')
            .doc(roomId)
            .set(modelLastMessage.toMap())
            .then((value) {
          emit(SocialCreateandUpdateUserSccessState());
        }).catchError((e) {
          emit(SocialCreateandUpdateUserErrorState(e));
        });
      } else {
        FirebaseFirestore.instance
            .collection('chat_Room')
            .doc(roomId)
            .update(modelLastMessage.toMap())
            .then((value) {
          emit(SocialCreateandUpdateUserSccessState());
        }).catchError((e) {
          emit(SocialCreateandUpdateUserErrorState(e));
        });
      }
    });
  }

  // List<MessageModel> messages = [];

  // void getMessages({
  //   required int? receiverId,
  //   required int? senderId,
  // }) {
  //   messages = [];
  //   FirebaseFirestore.instance
  //       .collection('user_chats')
  //       .doc(senderId.toString())
  //       .collection('chats')
  //       .doc(receiverId.toString())
  //       .collection('messages')
  //       .orderBy('dateTime')
  //       .snapshots()
  //       .listen((event) {
  //     messages.add(MessageModel.fromJson(event.docs.reversed.last.data()));
  //     // for (var element in event.docs.reversed) {
  //     //   messages.add(MessageModel.fromJson(element.data()));
  //     // }
  //     emit(SocialGetMessageSuccessStates());
  //   });
  // }
}
