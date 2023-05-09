import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:project1/module/show_post/show_post_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/layout/my_profile_layout/components/custem_image_profile.dart';

import 'package:project1/tes/ne/main_screen.dart';
import 'package:project1/tes/ne/sittings.dart';

class Profile1 extends StatefulWidget {
  static String routeName = "profile";

  @override
  State<Profile1> createState() => _ProfileState();
}

class _ProfileState extends State<Profile1> {
  bool s = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FadingScroller(
        builder: (context, scrollController) => ListView.builder(
          controller: scrollController,
          itemCount: 20,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.icecream),
            title: Text('Lorem ipsum #${index + 1}'),
          ),
        ),
      ),
    );
  }
}

class FadingScroller extends StatefulWidget {
  final Widget Function(BuildContext context, ScrollController scrollController)
      builder;

  final ScrollController? scrollController;

  const FadingScroller({Key? key, required this.builder, this.scrollController})
      : super(key: key);

  @override
  State<FadingScroller> createState() => _FadingScrollerState();
}

class _FadingScrollerState extends State<FadingScroller> {
  late final ScrollController _scrollController;

  bool _overlayIsVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_handleScrollUpdate);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      // Only dispise if it was _us_ creating the controller.
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _handleScrollUpdate() {
    if (_scrollController.position.extentAfter <= 0) {
      setState(() {
        _overlayIsVisible = false;
      });
    } else {
      setState(() {
        _overlayIsVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.builder(context, _scrollController),
        IgnorePointer(
          child: AnimatedOpacity(
            opacity: _overlayIsVisible ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00FFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                  stops: [
                    0.8,
                    1,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'like ',
    'deslike',
    'zain',
    'ahmad',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
