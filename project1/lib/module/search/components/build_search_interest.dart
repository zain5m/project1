import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/module/search/cubit/search_cubit.dart';
import 'package:project1/module/search/interst_screens.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';

// interestSearch
Widget buildSearchInterest({
  required String? interestName,
  required BuildContext? context,
}) =>
    TextButton(
      onPressed: () {
        navigateTo(context,
            InterstScreen(interstId: interestsName.indexOf(interestName!)));
      },
      clipBehavior: Clip.antiAlias,
      child: Text(
        '#$interestName',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(defaultColor),
      ),
    );

Widget interstPost({
  required int indexInterest,
  required context,
}) =>
    GestureDetector(
      onTap: () {
        navigateTo(
          context,
          InterstScreen(
            interstId: indexInterest,
          ),
        );
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(4)),
        child: Text(
          '#${interestsName[indexInterest]}',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: defaultColor,
            fontWeight: FontWeight.w600,
            // fontSize: 15,
          ),
        ),
      ),
    );
