import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/models/follow_model.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/network/remote/end_points.dart';

import 'package:project1/shared/styes/colors.dart';

Widget peopleBlockBottomSheet(context) {
  MyProfileLayoutCubit.get(context).blocking();
  return Column(
    children: [
      Divider(
        color: defaultColor,
        thickness: 4,
        height: 20,
        indent: MediaQuery.of(context).size.width / 2 - 30,
        endIndent: MediaQuery.of(context).size.width / 2 - 30,
      ),
      BlocConsumer<MyProfileLayoutCubit, MyProfileLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MyProfileLayoutCubit cubit = MyProfileLayoutCubit.get(context);

          return Expanded(
            child: state is MyProfileBlockingLoadingStates
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    itemCount: cubit.blockingPeople!.length,
                    itemBuilder: (context, index) => blockPeopleItem(
                      person: cubit.blockingPeople![index],
                      cubit: cubit,
                    ),
                    separatorBuilder: (context, index) => Divider(
                      height: 10,
                      thickness: 2,
                      // indent: MediaQuery.of(context).size.width / 4, //- 100,
                      // endIndent: MediaQuery.of(context).size.width / 8,
                      endIndent: 100,
                      // (MediaQuery.of(context).size.width / 4),
                    ),
                  ),
          );
        },
      ),
    ],
  );
}

Widget blockPeopleItem({
  required FollowAndBlockModel person,
  required MyProfileLayoutCubit cubit,
}) {
  return ListTile(
    leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: defaultColor,
            width: 3,
          ),
        ),
        child: person.photo != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(
                  "$HOST/$USERIMAGE/${person.photo!}",
                ),
              )
            : CircleAvatar(
                backgroundImage: AssetImage(
                  USERIMAGENULL,
                ),
              )),
    trailing: IconButton(
      onPressed: () {
        cubit.uNblockUser(userId: person.userId);
      },
      icon: Icon(
        Icons.person_off_outlined,
      ),
      color: defaultColor,
    ),
    title: Text(
      person.name!,
      style: TextStyle(
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}
