import 'package:flutter/material.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/models/Language.dart';

PopupMenuItem<int> languageItem({
  int? index,
  MyProfileLayoutCubit? cubit,
}) {
  // int? val = 2;
  return PopupMenuItem<int>(
    value: Language.languageList()[index!].id,
    onTap: () {
      cubit!.changeMenuIndex(Language.languageList()[index].id);
    },
    child: ListTile(
      selected: cubit!.currentMenuIndex == Language.languageList()[index].id
          ? true
          : false,
      selectedColor: Colors.black,
      selectedTileColor: Colors.black.withOpacity(0.1),
      leading: Text(Language.languageList()[index].flag),
      title: Text(Language.languageList()[index].name),
    ),
  );
}
