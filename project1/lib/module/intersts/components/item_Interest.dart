import 'package:flutter/material.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/module/intersts/cubit/intersts_cubit.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';

Widget buildInterestItem({
  int? index,
  String? interestsName,
  String? interestsImage,
  void Function()? ontap,
  // InterstsCubit? cubit,
  List<int>? selected,
}) =>
    InkWell(
      onTap: ontap,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: AlignmentDirectional.bottomStart,
        children: [
          // selected![index] == true
          selected!.contains(index)
              ? Container(
                  width: getProportionateScreenWidth(165),
                  height: getProportionateScreenHeight(165),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.5,
                      image: AssetImage(
                        "$interestsImage",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                    ),
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.darken,
                    border: Border.all(
                      width: 2,
                      color: defaultColor,
                    ),
                  ),
                )
              : Container(
                  width: getProportionateScreenWidth(165),
                  height: getProportionateScreenHeight(165),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "$interestsImage",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                    ),
                  ),
                  // child:
                ),
          // if (selected[index] == true)
          if (selected.contains(index))
            Positioned(
              top: getProportionateScreenHeight(5),
              right: getProportionateScreenWidth(5),
              child: Icon(
                Icons.check_circle,
                color: defaultColor,
              ),
            ),
          Positioned(
            bottom: 0,
            left: getProportionateScreenWidth(15),
            child: Text(
              "$interestsName",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xfff0f1f5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
