import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);
  var token = CacheHelper.getData(key: TOKEN);
}
