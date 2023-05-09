import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/module/intersts/components/item_Interest.dart';
import 'package:project1/module/intersts/cubit/intersts_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/layout/home_layout/home_layout.dart';

import '../../models/interstes/interests_model.dart';

class InterestsScreen extends StatelessWidget {
  static String routeName = "/interests";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
        create: (context) => InterstsCubit(),
        child: BlocConsumer<InterstsCubit, InterstsStates>(
          listener: (context, state) {
            if (state is RegisterAddInsterstsSucssesState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppLayout.routeName,
                (route) => false,
              );
            }
            if (state is RegisterAddInsterstsErrorState) {
              showToast(
                text: state.error,
                state: ToastState.ERROR,
              );
            }
          },
          builder: (context, state) {
            var cubit = InterstsCubit.get(context);
            return interstScreen(
              context: context,
              selected: cubit.selected,
              selectedForAPI: cubit.selectedForAPI,
              cubit: cubit,
              text: 'Next',
            );
          },
        ));
  }
}

// cubit.selected
//
//
Widget interstScreen({
  required BuildContext context,
  required List<int> selected,
  required List<int> selectedForAPI,
  required InterstsCubit cubit,
  required String text,
  bool isUpdate = false,
}) =>
    SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pick your interest :",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(18),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: interestsName.length,
                  itemBuilder: (context, index) => buildInterestItem(
                    index: index,
                    interestsName: interestsName[index],
                    interestsImage: interestsImage[index],
                    selected: selected,
                    ontap: () {
                      cubit.changeInterstsSelected(index);
                    },
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: getProportionateScreenWidth(24),
                    mainAxisSpacing: getProportionateScreenHeight(9),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  defaultButton(
                    function: isUpdate
                        ? () {
                            if (selectedForAPI.isNotEmpty) {
                              cubit.UpdateInterst(
                                intersts: cubit.selectedForAPI,
                              );
                            }
                          }
                        : () {
                            if (selectedForAPI.isNotEmpty) {
                              cubit.userRegisterAddIntersts(
                                intersts: cubit.selectedForAPI,
                              );
                            }
                            if (selectedForAPI.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                validatorSnackBarInterests(
                                  text: 'You should choose interest',
                                  state: ToastState.ERROR,
                                ),
                              );
                            }
                          },
                    text: text,
                    fontSize: 15,
                    radius: 19,
                    width: getProportionateScreenWidth(140),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
