import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/styes/colors.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

Future<Response> sendFile(String url, File? file) async {
  final token = CacheHelper.getData(key: TOKEN);
  print(token);
  var len = await file!.length();

  Dio dio = Dio();
  // dio.options.responseType = ResponseType.plain;
  // dio.options.headers["Content-Length"] = len;
  // Headers.contentLengthHeader: len,

  // dio.options.headers['Accept'] = "application/json";
  // dio.options.headers['Content-Type'] = "multipart/form-data";
  var response = await dio.post(
    url,
    data: {
      "photo": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    },
    options: Options(
      responseType: ResponseType.json,
      // contentType: 'multipart/form-data',
      // headers: {
      //   "Authorization": "Bearer 44|wHLxq24mOigvizlWnFGaiZ244UO7J3p75MYSYUaY",
      //   "Content-Type": "application/json ;multipart/form-data",
      // },
      headers: {
        // Headers.contentLengthHeader: len,
        // multipart/form-data
        "Accept": "Application/javascript",
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer $token",
        // "Content-Length": '${len.toString()}',
      },
    ),
  );
  return response;
}
//
// Future<XFile?> takePhoto() async {
//   ImagePicker imagepicker = ImagePicker();
//   final pickedImage = await imagepicker.pickImage(
//       source: ImageSource.gallery, imageQuality: 100);
//
//   try {
//     return pickedImage!;
//
//     // Navigator.pop(context);
//
//   } catch (e) {
//     return null;
//   }
//
//   // Get.back();
// }

class Addphoto extends StatefulWidget {
  const Addphoto({Key? key}) : super(key: key);

  @override
  State<Addphoto> createState() => _AddphotoState();
}

class _AddphotoState extends State<Addphoto> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Add Profile Picture",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 70,
          ),
          SingleChildScrollView(
            child: Column(children: [
              CircleAvatar(
                radius: 190,
                backgroundImage: AssetImage(
                  'assets/images/interests/music.jpg',
                ),
                //radius: 300,
              ),
              SizedBox(
                height: 15,
              ),
              TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                FluentIcons.image_multiple_48_filled,
                                color: defaultColor,
                                size: 30,
                              ),
                              title: Text(
                                'Gallary',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                // takePhoto().then((value) {
                                //   sendFile(
                                //     "http://192.168.1.103:8000/api/myprofile/photo",
                                //     File(value!.path),
                                //   ).then((value) {
                                //     print(value);
                                //   });
                                //   print(value);
                                // });
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.camera,
                                color: defaultColor,
                                size: 30,
                              ),
                              title: Text(
                                'Camera',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(
                  FluentIcons.shape_intersect_24_filled,
                  size: 45,
                  color: defaultColor,
                ),
                label: Text(
                  "Tab to Add",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: defaultColor,
                  ),
                ),
              )
            ]),
          ),
          // SizedBox(
          //       height: 203,
          //     ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(4),
                child: defaultButton(
                  function: () {
                    // Todo: NAv +send +if(formkey)
                  },
                  text: 'Next',
                  fontSize: 15,
                  radius: 19,
                  width: 140,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
