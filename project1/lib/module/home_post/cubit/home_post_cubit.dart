import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/models/home_post/home_post_model.dart';
import 'package:project1/models/post_model.dart';
import 'package:project1/models/user_model.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';
part 'home_post_state.dart';

class HomePostCubit extends Cubit<HomePostStates> {
  HomePostCubit() : super(HomePostInitialState());
  static HomePostCubit get(context) => BlocProvider.of(context);

  HomePostModel? data;
  var token = CacheHelper.getData(key: TOKEN);

  void getHomePost() {
    emit(GetHomePostsLoadingStates());
    DioHelper.getData(
      url: HomePost,
      token: 'Bearer $token',
    ).then((response) {
      if (response.statusCode == 200) {
        data = HomePostModel.fromJson(response.data);

        emit(GetHomePostsSuccessStates());
      } else if (response.statusCode! >= 500) {
        emit(GetHomePostsErrorStates("Error on server"));
      } else {
        emit(GetHomePostsErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
      emit(GetHomePostsErrorStates(error.toString()));
    });
  }

  // !

  void updatePost({
    required String postId,
    required String? content,
    required List<int>? interestid,
    required int index,
  }) {
    emit(UpdatePostLoadingState());
    FormData formData = FormData.fromMap({
      "content": content,
      "interest_id": interestid.toString().replaceAll(' ', '').toString(),
    });
    DioHelper.putData(
      url: "post/$postId",
      token: 'Bearer $token',
      data: formData,
    ).then((response) {
      if (response.statusCode == 200) {
        // data!.posts!.homeModel!.removeAt(index);
        // data!.posts!.homeModel!.add(HomeModel.fromJson(response.data));
        // print('ssssssssssssssssssss');
        getHomePost();

        emit(UpdatePostSuccessState());
      } else if (response.statusCode! >= 500) {
        emit(UpdatePostErrorStat("Error on server"));
      } else {
        emit(UpdatePostErrorStat(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
      emit(UpdatePostErrorStat(error.toString()));
    });
  }
// !!

  void addPost({
    required String? userName,
    required String? userPhoto,
    required int? userId,
    required String? postId,
    required String? content,
    required String? photo,
    // required String? isPrometed,
    required List<int>? interestId,
  }) {
    HomeModel post = HomeModel(
      post: PostModel(
        commentsNumber: 0,
        content: content,
        createdAt: DateTime.now(),
        downVotesNumber: 0,
        downvotesUserId: [],
        interestId: interestId,
        isPrometed: "0",
        photo: photo,
        postId: postId,
        react: "No React",
        upVotesNumber: 0,
        updatedAt: null,
        upvotesUserId: [],
        user: UserModel(
          name: userName,
          photo: userPhoto,
        ),
        userId: userId,
      ),
    );
    data!.posts!.homeModel!.add(post);
    emit(AddPostState());
  }

// !
  void deletePost({
    required String? postId,
    required int? index,
  }) {
    emit(DeletPostLoadingStates());
    DioHelper.deleteData(
      url: 'post/$postId',
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        // data!.posts!.homeModel!.removeAt(index!);
        getHomePost();
        emit(DeletPostSuccessStates());
      } else if (response.statusCode! >= 500) {
        emit(DeletPostErrorStates("Error on server"));
      } else {
        emit(DeletPostErrorStates(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
    });
  }

  void deleteStory({
    required int? storyId,
    required int? index,
  }) {
    emit(DeletStoryLoadingStates());

    DioHelper.deleteData(
      url: 'story/delete/$storyId',
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        data!.stories!.remove(data!.stories![index!]);
        emit(DeletStorySuccessStates());
      } else if (response.statusCode! >= 500) {
        emit(DeletStoryErrorStates("Error on server"));
      } else {
        emit(
            DeletStoryErrorStates(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
    });
  }

  void upvot({
    required String? postId,
    required int index,
  }) {
    emit(ReactLoadingState());
    DioHelper.postData(
      url: "post/$postId/$UPVOTE",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        if (response.data == 0) {
          data!.posts!.homeModel![index].post!.react = "No React";
          int up = data!.posts!.homeModel![index].post!.upVotesNumber!;
          data!.posts!.homeModel![index].post!.upVotesNumber = up - 1;
          emit(ReactSuccessState());
        } else {
          data!.posts!.homeModel![index].post!.react = "Upvoted";
          int up = data!.posts!.homeModel![index].post!.upVotesNumber!;
          data!.posts!.homeModel![index].post!.upVotesNumber = up + 1;

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
    required int? index,
  }) {
    emit(ReactLoadingState());
    DioHelper.postData(
      url: "post/$postId/$DOWNVOTE",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        // getShowPost(postId: postId);
        if (response.data == 0) {
          data!.posts!.homeModel![index!].post!.react = "No React";
          int down = data!.posts!.homeModel![index].post!.downVotesNumber!;
          data!.posts!.homeModel![index].post!.downVotesNumber = down - 1;

          emit(ReactSuccessState());
        } else {
          data!.posts!.homeModel![index!].post!.react = "Downvoted";
          int down = data!.posts!.homeModel![index].post!.downVotesNumber!;
          data!.posts!.homeModel![index].post!.downVotesNumber = down + 1;
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
}
