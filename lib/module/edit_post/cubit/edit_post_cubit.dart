import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/home_post/home_post_model.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostStates> {
  EditPostCubit() : super(EditPostInitialState());
  static EditPostCubit get(context) => BlocProvider.of(context);

  bool showInterste = false;

  IconData iconshowInterste = FluentIcons.arrow_circle_right_48_filled;

  void changeShowInterste() {
    showInterste = !showInterste;

    iconshowInterste = showInterste
        ? FluentIcons.arrow_circle_down_48_filled
        : FluentIcons.arrow_circle_right_48_filled;

    emit(EditPostChangeShowIntersteState());
  }

  // Map<int, bool> selected = {};

  List<int> selected = [];
  List<int> selectedForAPI = [];

  void changeInterstsSelected(int interestsid) {
    if (selected.contains(interestsid)) {
      selected.remove(interestsid);
      selectedForAPI.remove(interestsid + 1);
    } else {
      selected.add(interestsid);
      selectedForAPI.add(interestsid + 1);
    }

    // if (selected[interestsid] == true) {
    //   selected.remove(interestsid);
    // } else {
    //   selected[interestsid] = true;
    // }
    emit(EditPostChangeInterstsSelectedState());
  }

  void getinter({
    required list,
  }) {
    selectedForAPI = [];
    selected = [];
    list!.forEach((element) {
      selected.add(element);
      selectedForAPI.add(element + 1);
    });
  }
}
