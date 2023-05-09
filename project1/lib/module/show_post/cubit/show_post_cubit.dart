import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/comment_model.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/models/explore_model.dart';
import 'package:project1/models/show_post_model.dart';
import 'package:project1/models/user_model.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';

part 'show_post_state.dart';

class ShowPostCubit extends Cubit<ShowPostStates> {
  ShowPostCubit() : super(ShowPostInitialState());

  static ShowPostCubit get(context) => BlocProvider.of(context);
  var token = CacheHelper.getData(key: TOKEN);

  ShowPostModel? data;
  void getShowPost({
    required String? postId,
  }) {
    emit(ShowPostLoadingState());
    DioHelper.getData(
      url: "$SHOW/$postId",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        data = ShowPostModel.fromJson(response.data['Post']);

        emit(ShowPostSuccessState());
      } else if (response.statusCode! >= 500) {
        emit(ShowPostErrorState("Error on server"));
      } else {
        emit(ShowPostErrorState(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
    });
  }

  void sendComment({
    required String? postId,
    required String? comment,
  }) {
    print(token);
    emit(SendCommentLoadingState());
    DioHelper.postData(
      url: "post/$postId/$COMMENT",
      data: {
        'comment': comment,
      },
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        print(response.data);
        emit(SendCommentSuccessState());
      } else if (response.statusCode! >= 500) {
        print(response);
        emit(SendCommentErrorState("Error on server"));
      } else {
        print(response);

        emit(
            SendCommentErrorState(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
    });
  }

  void upvot({
    required String? postId,
  }) {
    emit(ReactLoadingState());
    DioHelper.postData(
      url: "post/$postId/$UPVOTE",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        if (response.data == 0) {
          data!.post!.react = "No React";
          int up = data!.post!.upVotesNumber!;
          data!.post!.upVotesNumber = up - 1;
          emit(ReactSuccessState());
        } else {
          data!.post!.react = "Upvoted";
          int up = data!.post!.upVotesNumber!;
          data!.post!.upVotesNumber = up + 1;
          emit(ReactSuccessState());
        }
        emit(ReactSuccessState());
      } else if (response.statusCode! >= 500) {
        emit(ReactErrorState("Error on server"));
      } else {
        emit(ReactErrorState(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
    });
  }

  void downVot({
    required String? postId,
  }) {
    emit(ReactLoadingState());
    DioHelper.postData(
      url: "post/$postId/$DOWNVOTE",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        // getShowPost(postId: postId);
        if (response.data == 0) {
          data!.post!.react = "No React";
          int down = data!.post!.downVotesNumber!;
          data!.post!.downVotesNumber = down - 1;
          emit(ReactSuccessState());
        } else {
          data!.post!.react = "Downvoted";
          int down = data!.post!.downVotesNumber!;
          data!.post!.downVotesNumber = down + 1;
          emit(ReactSuccessState());
        }
      } else if (response.statusCode! >= 500) {
        emit(ReactErrorState("Error on server"));
      } else {
        emit(ReactErrorState(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
    });
  }

// post/62d00b75bac685f5fc024199/comment/{id}/delete'
// post/62d00b75bac685f5fc024199/comment/379413738/update

  void deletComment({
    required String? postId,
    required int? commentId,
    required int? index,
  }) {
    emit(DeletCommentLoadingState());
    DioHelper.deleteData(
      url: "post/$postId/comment/$commentId/delete",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        data!.comments!.removeAt(index!);
        emit(DeletCommentSuccessState());
      } else if (response.statusCode! >= 500) {
        emit(DeletCommentErrorState("Error on server"));
      } else {
        emit(DeletCommentErrorState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
    });
  }

  void updateComment({
    required String postId,
    required int commentId,
    required int index,
    required String content,
  }) {
    emit(UpdateCommentLoadingState());
    DioHelper.putData(
      url: "post/$postId/comment/$commentId/update",
      token: token,
      data: {
        'content': content,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        CommentModel comentup = CommentModel(
          commentId: commentId,
          content: content,
          createdAt: data!.comments![index].createdAt,
          user: data!.comments![index].user,
          userId: data!.comments![index].userId,
        );
        data!.comments!.removeAt(index);
        data!.comments!.add(comentup);
        emit(UpdateCommentSuccessState());
      } else if (response.statusCode! >= 500) {
        emit(UpdateCommentErrorState("Error on server"));
      } else {
        emit(UpdateCommentErrorState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
    });
  }

  void addComment({
    required String? name,
    required String? photo,
    required int? userId,
    required int? commentId,
    required String? content,
    required String? createdAt,
  }) {
    CommentModel comentREal = CommentModel(
      user: UserModel(
        name: name,
        photo: photo,
      ),
      userId: userId,
      commentId: commentId,
      content: content,
      createdAt: createdAt,
    );
    // int index = data!.comments!.length;
    List<CommentModel> myList = [comentREal, ...data!.comments!];
    data!.comments = myList;
    emit(AddCommentState());
  }
}
