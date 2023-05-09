import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/module/home_post/components/buid_post_home_item.dart';
import 'package:project1/module/intersts/interests_screen.dart';
import 'package:project1/module/search/cubit/search_cubit.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';

class InterstScreen extends StatelessWidget {
  int? interstId;
  InterstScreen({
    required this.interstId,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(
          interestsName[interstId!],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                interestsImage[interstId!],
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            SearchCubit()..getSearchIntest(interstId: interstId! + 1),
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            SearchCubit cubit = SearchCubit.get(context);
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(15)),
              child: cubit.interestSearch != null
                  ? ListView.separated(
                      itemBuilder: (context, index) => buidPostHomeItem(
                        index: index,
                        context: context,
                        post: cubit.interestSearch![index],
                      ),
                      itemCount: cubit.interestSearch!.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          },
        ),
      ),
    );
  }
}
