import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/profile/profile_screen.dart';
import 'package:project1/module/search/custom_search_delegate_secreen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/cubit/app_cubit.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';

class PartTopHomeSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: getProportionateScreenHeight(60),
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 10),
        child: BlocBuilder<AppCubit, AppStates>(
          // listener: (context, state) {},
          builder: (context, state) {
            AppCubit appCubit = AppCubit.get(context);
            return IconButton(
              icon: Icon(
                appCubit.iconTheme,
                size: 35,
                color: defaultColor,
              ),
              onPressed: () {
                appCubit.changeAppMode();
              },
            );
          },
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegateSecreen(
                // items: People,
                searchLabel: 'Search people',
                suggestion: Center(
                  child: Text('Filter people by name'),
                ),
                failure: Center(
                  child: Text('No person found :('),
                ),
                // filter: (person) => [person.name],

                builder: (person) => ListTile(
                  onTap: () {
                    // navigateTo(
                    //     context,
                    //     ProfileScreen(
                    //       userId: person.userId,
                    //     ));
                  },
                  title: Text(person.name),
                  leading: person.photo != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            "$HOST/$USERIMAGE/${person.photo}",
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage(
                            USERIMAGENULL,
                          ),
                        ),
                ),
              ),
            );
          },
          icon: Icon(
            // IconBroken.Search,
            FluentIcons.people_search_24_regular,
            // .search,
            size: 35,
            color: defaultColor,
          ),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
