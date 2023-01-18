// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/city_news_model.dart';
import '../../view-model/fetch_data_vm.dart';
import '../resources/app_textstyle.dart';
import '../resources/resources.dart';
import 'component/feed_block.dart';

class FeedScreen extends StatefulWidget {
  final String cityName;
  final String id;
  List<CityNewsModel>? list;

  FeedScreen({Key? key, required this.cityName, required this.id, this.list})
      : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // final ReviewRepository _reviewRepository = ReviewRepository();
  FetchData? _fetchData;

  @override
  void didChangeDependencies() {
    _fetchData = Provider.of<FetchData>(context, listen: false);
    // Provider.of<FetchData>(context, listen: false)
    //     .fetchPodcast(context: context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, widget.cityName),
      body: SafeArea(
          child: Column(
        children: [
          kTinyVerticalSpacing,
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<List<CityNewsModel>>(
                  future: _fetchData?.getNewsContentsFromDb(
                      context: context, id: widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          int reversedIndex = snapshot.data!.length - 1 - index;
                          return FeedbackBlock(
                              news: snapshot.data![reversedIndex].cityNews,
                              user: snapshot.data![reversedIndex].user,
                              time: snapshot.data![reversedIndex].time);
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          strokeWidth: 1,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Somethinng went wrong',
                          style: bodySmallText(context),
                        ),
                      );
                    }
                  }),
            ),
          ),
        ],
      )),
    );
  }

  AppBar _buildAppBar(BuildContext context, String cityName) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text("Crime reports on $cityName",
          style: bodyNormalText(context).copyWith(color: kWhiteColor)),
      // actions: [
      //   IconButton(
      //       onPressed: () {

      //       },
      //       icon: Icon(
      //         Icons.share,
      //       )),
      //   IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.star_border_purple500_outlined,
      //       ))
      // ],
    );
  }
}
