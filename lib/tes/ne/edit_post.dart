import 'package:flutter/material.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/module/home_post/components/buid_my_stoey.dart';
import 'package:project1/module/home_post/components/buid_stoey_item.dart';
import 'package:project1/module/intersts/components/item_Interest.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../module/intersts/interests_screen.dart';

class EditPost extends StatefulWidget {
  const EditPost({Key? key}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  Widget interests(String name) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Center(
        child: Row(children: [
          Text(
            "#",
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: defaultColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            name,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: defaultColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Edit Post",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                //Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(220, 0, 0, 0),
                  child: TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {},
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: hintFieldColor,
              thickness: 1,
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.only(
                        left: 21, right: 17, top: 15, bottom: 8),
                    // width: getProportionateScreenWidth(346),
                    // height: getProportionateScreenHeight(493),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        //  boxShadow: [
                        //    BoxShadow(
                        //      color: const Color(0x0f000000),
                        //      offset: Offset(0, 20),
                        //      blurRadius: 60,
                        //    )
                        //  ],
                        // color: Colors.white,
                        ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // CircleAvatar(
                            //   backgroundImage: post!.photo != null
                            //       ? NetworkImage(
                            //           "http://images/PostsPhoto/${post.photo}",
                            //         )
                            //       : null,
                            // ),
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                //TODO: Add a images publisher
                                'assets/images/interests/art.jpg',
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //TODO: Add a name publisher

                                  "Mauricio Lopez",

                                  style: const TextStyle(
                                    color: const Color(0xff181818),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              hintText: "Enter your Description",
                              hintStyle: TextStyle(
                                color: hintFieldColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            // child: Image.network(
                            //   // fit: BoxFit.cover,
                            //   'http://192.168.1.11:8000/images/PostsPhoto/',
                            // ),

                            child: Image.asset(
                              'assets/images/interests/graphic_design.jpg',
                              width: 329,
                              height: 295,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FluentIcons.dismiss_48_filled,
                                size: 20,
                                color: Colors.white,
                              )),
                        ]),
                        SizedBox(height: 5),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // post.interestId.f
                            interests("Programming C++"),
                            interests("Graphic Design"),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Container(
                                                  width: 165,
                                                  height: 165,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/images/interests/graphic_design.jpg',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(19),
                                                    ),
                                                  ),
                                                  // child:
                                                ),
                                              ),
                                              Text(
                                                "Flower",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 20,
                                        ),
                                        itemCount: 15,
                                      );
                                    });
                              },
                              icon: Icon(
                                FluentIcons.arrow_circle_right_48_filled,
                                size: 40,
                                color: defaultColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
