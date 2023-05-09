import 'package:flutter/cupertino.dart';
import 'package:project1/models/explore_model.dart';
import 'package:project1/module/explore/buildPostExploreItem.dart';

Widget buildListExplore({
  required BuildContext context,
  required BoxConstraints constraints,
  required List<ExploreModel> list,
  required bool isRight,
}) =>
    Flexible(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 5, bottom: 60),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return index % 2 == 0
              ? buildPostExploreItem(
                  context: context,
                  constraints: constraints,
                  cubit: list[index],
                  isSmall: isRight ? true : false,
                )
              : buildPostExploreItem(
                  context: context,
                  constraints: constraints,
                  cubit: list[index],
                  isSmall: isRight ? false : true,
                );
        },
      ),
    );
