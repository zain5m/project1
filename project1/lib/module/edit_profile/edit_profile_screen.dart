import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/models/register/list_model.dart';
import 'package:project1/models/user_data_model.dart';
import 'package:project1/module/edit_profile/components.dart';
import 'package:project1/module/edit_profile/edit_photo_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? genderChoose;
  String? dayChoose;
  String? monthChoose;
  String? yearChoose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            AppLayoutCubit.get(context).changeBottomNav(3);
            navigateTo(context, AppLayout());
          },
          color: Colors.black,
        ),
        title: Text(
          'Edit profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: BlocConsumer<MyProfileLayoutCubit, MyProfileLayoutStates>(
            listener: (context, state) {},
            builder: (context, state) {
              MyProfileLayoutCubit cubit = MyProfileLayoutCubit.get(context);
              if (cubit.myProfileData == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                UserDataModel user = cubit.myProfileData!.myInfo!.personal!;
                nameController.text = user.name!;
                bioController.text = user.bio!;
                genderChoose = user.gender == 1 ? 'Female' : 'Male';
                dayChoose = user.birthday!.day.toString().length == 1
                    ? "0${user.birthday!.day.toString()}"
                    : user.birthday!.day.toString();
                monthChoose = user.birthday!.month.toString().length == 1
                    ? "0${user.birthday!.month.toString()}"
                    : user.birthday!.month.toString();
                yearChoose = user.birthday!.year.toString();

                return state is MyProfileEditprofileLoadingStates ||
                        state is MyProfileEditprofileLoadingStates
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  user.photo == null
                                      ? CircleAvatar(
                                          radius: 90,
                                          backgroundImage: AssetImage(
                                            USERIMAGENULL,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 90,
                                          backgroundImage: NetworkImage(
                                            "$HOST/$USERIMAGE/${user.photo}",
                                          ),
                                        ),
                                  IconButton(
                                    onPressed: () {
                                      navigateTo(context, EditPhotoScreen());
                                    },
                                    icon: CircleAvatar(
                                      // radius: 600.0,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 29.0,
                                        color: defaultColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                            defaultFormFeild(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'pless enter your name';
                                }
                                return null;
                              },
                              controller: nameController,
                              label: 'UserName',
                              prefix: Icons.account_circle,
                            ),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            Text(
                              'Bio',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                            defaultFormFeild(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'pless enter your Bio ';
                                }
                                return null;
                              },
                              controller: bioController,
                              label: 'Bio',
                              prefix: Icons.edit,
                              isMax: true,
                            ),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                            defultProgileDropdownButton(
                              hint: 'Select Gender',
                              valueChoose: genderChoose,
                              isExpanded: true,
                              onChanged: (newvalue) {
                                genderChoose = newvalue.toString();
                              },
                              list: genderList,
                              validate: (value) {
                                if (value == null) {
                                  return 'pless enter your gender';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            Text(
                              'Select Your Birthday',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: defultProgileDropdownButton(
                                    hint: 'Day',
                                    valueChoose: dayChoose,
                                    onChanged: (newvalue) {
                                      dayChoose = newvalue.toString();
                                    },
                                    list: dayList,
                                    validate: (value) {
                                      if (value == null) {
                                        return 'pless enter your Day';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: defultProgileDropdownButton(
                                    hint: 'Month',
                                    valueChoose: monthChoose,
                                    onChanged: (newvalue) {
                                      monthChoose = newvalue.toString();
                                    },
                                    list: monthList,
                                    validate: (value) {
                                      if (value == null) {
                                        return 'pless enter your Month';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: defultProgileDropdownButton(
                                    hint: 'Year',
                                    valueChoose: yearChoose,
                                    onChanged: (newvalue) {
                                      yearChoose = newvalue.toString();
                                    },
                                    list: yearList,
                                    validate: (value) {
                                      if (value == null) {
                                        return 'pless enter your Year';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(55)),
                            Center(
                              child: defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.editprofile(
                                      name: nameController.text,
                                      birthDay:
                                          "${yearChoose}/${monthChoose}/${dayChoose}",
                                      gender: genderChoose == 'Male' ? 2 : 1,
                                      bio: bioController.text,
                                    );
                                  }
                                },
                                text: 'Save',
                                width: getProportionateScreenWidth(120),
                              ),
                            ),
                          ],
                        ),
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
