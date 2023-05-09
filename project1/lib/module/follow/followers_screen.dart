import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/models/follow_model.dart';
import 'package:project1/module/follow/build_follow_pepole.dart';
import 'package:project1/module/follow/cubit/follow_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/routes/routes.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class FollowersScreen extends StatelessWidget {
  int? userId;
  FollowersScreen({this.userId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            'Followers',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsetsDirectional.only(top: getProportionateScreenHeight(15)),
          child: BlocProvider(
            create: (context) => FollowCubit()..getFollowers(userId: userId),
            child: BlocConsumer<FollowCubit, FollowStates>(
              listener: (context, state) {},
              builder: (context, state) {
                FollowCubit cubit = FollowCubit.get(context);
                return state is FollowGetFollowersLoadingStates
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : cubit.followers!.length == 0
                        ? Center(
                            child: Text(
                              'There are no Followers.',
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return buildFollowPepole(
                                person: cubit.followers![index],
                                context: context,
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            itemCount: cubit.followers!.length,
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Widget followepepole(String image, String name, BuildContext context) {
//   return Row(
//     children: [
//       Padding(
//         padding: EdgeInsets.all(8),
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: LinearGradient(
//               begin: Alignment(0.5, 0),
//               end: Alignment(0.5, 1),
//               colors: [defaultColor, defaultColor],
//             ),
//             border: Border.all(
//               color: Colors.transparent,
//               width: 3,
//             ),
//           ),
//           child: CircleAvatar(
//             backgroundImage: AssetImage(
//               image,
//             ),
//             radius: 30,
//           ),
//         ),
//       ),
//       SizedBox(width: 5),
//       Text(
//         name,
//         style: TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w400,
//           fontStyle: FontStyle.italic,
//         ),
//       ),
//       SizedBox(width: 12),
//       IconButton(
//           onPressed: () {},
//           icon: Icon(
//             FluentIcons.chat_48_regular,
//             size: 25,
//             color: defaultColor,
//           )),
//       Spacer(),
//       IconButton(
//         onPressed: () {},
//         icon: Icon(
//           Icons.arrow_forward_ios_rounded,
//           size: 25,
//         ),
//       ),
//     ],
//   );
// }
