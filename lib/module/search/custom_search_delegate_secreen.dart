import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/profile/profile_screen.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/module/search/components/build_search_interest.dart';
import 'package:project1/module/search/cubit/search_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';

typedef SearchFilter<T> = List<String?> Function(T t);
typedef ResultBuilder<T> = Widget Function(T t);

class CustomSearchDelegateSecreen extends SearchDelegate {
  final Widget suggestion;
  final Widget failure;
  final ResultBuilder<dynamic> builder;
  // final SearchFilter<dynamic> filter;
  final String? searchLabel;
  // final List<dynamic> items;
  final bool itemStartsWith = false;
  final bool itemEndsWith = false;
  // final void Function(String)? onQueryUpdate;
  CustomSearchDelegateSecreen({
    this.suggestion = const SizedBox(),
    this.failure = const SizedBox(),
    required this.builder,
    // required this.filter,
    // required this.items,
    this.searchLabel,
    // this.onQueryUpdate,
  }) : super(
          searchFieldLabel: searchLabel,
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      AnimatedOpacity(
        opacity: query.isNotEmpty ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOutCubic,
        child: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // final String cleanQuery = query.toLowerCase().trim();
    // final List<dynamic> result = items.where(
    //   (item) {
    //     return filter(item).map((value) {
    //       return value?.toLowerCase().trim();
    //     }).any(
    //       (value) {
    //         if (itemStartsWith == true && itemEndsWith == true) {
    //           return value == cleanQuery;
    //         } else if (itemStartsWith == true) {
    //           return value?.startsWith(cleanQuery) == true;
    //         } else if (itemEndsWith == true) {
    //           return value?.endsWith(cleanQuery) == true;
    //         } else {
    //           return value?.contains(cleanQuery) == true;
    //         }
    //       },
    //     );
    //   },
    // ).toList();
    if (query.isNotEmpty) {
      return BlocProvider(
        create: (context) =>
            SearchCubit()..getSearchUser(user: query.toString()),
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            SearchCubit cubit = SearchCubit.get(context);
            state is SearshUserSucsses
                ? print(cubit.userSearch.length)
                : print('object');
            return state is SearshUserSucsses
                ?
                // ListView.builder(
                // shrinkWrap: true,
                // itemBuilder: (context, index) =>
                ListView(
                    children: cubit.userSearch.map(builder).toList(),
                  )
                // itemCount: cubit.userSearch.length,
                // )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      );
    } else {
      return buildSuggestions(context);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // if (onQueryUpdate != null) onQueryUpdate!(query);

    // final String cleanQuery = query.toLowerCase().trim();
    // final List<dynamic> result = items.where(
    //   (item) {
    //     return filter(item).map((value) {
    //       return value?.toLowerCase().trim();
    //     }).any(
    //       (value) {
    //         if (itemStartsWith == true && itemEndsWith == true) {
    //           return value == cleanQuery;
    //         } else if (itemStartsWith == true) {
    //           return value?.startsWith(cleanQuery) == true;
    //         } else if (itemEndsWith == true) {
    //           return value?.endsWith(cleanQuery) == true;
    //         } else {
    //           return value?.contains(cleanQuery) == true;
    //         }
    //       },
    //     );
    //   },
    // ).toList();

    return
        //  query.isEmpty
        // ?
        Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(5),
          vertical: getProportionateScreenHeight(20)),
      child: Wrap(
        spacing: getProportionateScreenWidth(15),
        runSpacing: getProportionateScreenHeight(10),
        children: List.generate(
          interestsName.length,
          (index) => buildSearchInterest(
            context: context,
            interestName: interestsName[index],
          ),
        ),
      ),
    );
    // : cleanQuery.isEmpty
    //     ? suggestion
    //     : result.isEmpty
    //         ? failure
    //         : ListView(
    //             children: result.map(builder).toList(),
    // );
    // : FadingScroller(
    //     builder: (context, scrollController) => ListView(
    //       controller: scrollController,
    //       children: result.map(builder).toList(),
    //     ),
    //   );
  }
}

// !!Fading Scroller AnimatedOpacity

// class FadingScroller extends StatefulWidget {
//   final Widget Function(BuildContext context, ScrollController scrollController)
//       builder;

//   final ScrollController? scrollController;

//   const FadingScroller({Key? key, required this.builder, this.scrollController})
//       : super(key: key);

//   @override
//   State<FadingScroller> createState() => _FadingScrollerState();
// }

// class _FadingScrollerState extends State<FadingScroller> {
//   late final ScrollController _scrollController;

//   bool _overlayIsVisible = true;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = widget.scrollController ?? ScrollController();
//     _scrollController.addListener(_handleScrollUpdate);
//   }

//   @override
//   void dispose() {
//     if (widget.scrollController == null) {
//       // Only dispise if it was _us_ creating the controller.
//       _scrollController.dispose();
//     }
//     super.dispose();
//   }

//   void _handleScrollUpdate() {
//     if (_scrollController.position.extentAfter <= 0) {
//       setState(() {
//         _overlayIsVisible = false;
//       });
//     } else {
//       setState(() {
//         _overlayIsVisible = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         widget.builder(context, _scrollController),
//         IgnorePointer(
//           child: AnimatedOpacity(
//             opacity: _overlayIsVisible ? 1 : 0,
//             duration: Duration(milliseconds: 500),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0x00FFFFFF),
//                     // defaultColor.withOpacity(0.1),
//                     // defaultSecondColor.withAlpha(0),
//                     Color(0xFFFFFFFF),
//                   ],
//                   stops: [
//                     0.8,
//                     // 0.9,
//                     1,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
