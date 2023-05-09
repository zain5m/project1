import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/module/intersts/components/item_Interest.dart';
import 'package:project1/module/intersts/cubit/intersts_cubit.dart';
import 'package:project1/module/intersts/interests_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/layout/home_layout/home_layout.dart';

import '../../models/interstes/interests_model.dart';

class UpdateInterestsScreen extends StatelessWidget {
  List<int>? interest;
  UpdateInterestsScreen({required this.interest});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => InterstsCubit()..getintest(interest: interest!),
      child: BlocConsumer<InterstsCubit, InterstsStates>(
        listener: (context, state) {
          if (state is UpdateInsterstsSucssesState) {
            AppLayoutCubit.get(context).changeBottomNav(3);
            Navigator.pop(context);
            // navigateTo(
            //   context,
            //   AppLayout(),
            // );
          }
          if (state is UpdateInsterstsErrorState) {
            showToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
        },
        builder: (context, state) {
          InterstsCubit cubit = InterstsCubit.get(context);
          return interstScreen(
            text: 'Update',
            context: context,
            selected: cubit.selected,
            selectedForAPI: cubit.selectedForAPI,
            cubit: cubit,
            isUpdate: true,
          );
        },
      ),
    );
  }
}
