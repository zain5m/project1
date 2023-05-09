import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/models/explore_model.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreStates> {
  ExploreCubit() : super(ExploreInitialState());

  ExploreCubit get(context) => BlocProvider.of(context);
  List<ExploreModel> dataRight = [];
  List<ExploreModel> dataLeft = [];

  void getData() {
    emit(ExploreGetDataLoadingState());
    final token = CacheHelper.getData(key: TOKEN);
    print(token);
    DioHelper.getData(
      url: EXPLORE,
      token: token,
    ).then((response) {
      dataRight = [];
      dataLeft = [];

      if (response.statusCode == 200) {
        for (int i = 0; i < response.data.length; i++) {
          if (i % 2 == 0) {
            dataRight.add(ExploreModel.fromJson(response.data[i]));
          } else {
            dataLeft.add(ExploreModel.fromJson(response.data[i]));
          }
        }
        emit(ExploreGetDataSucssesState());
      } else if (response.statusCode! >= 500) {
        emit(ExploreGetDataErrorState("Error on server"));
      } else {
        emit(ExploreGetDataErrorState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
      emit(ExploreGetDataErrorState("Error on server"));
    });
  }
}
