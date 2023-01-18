import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safespace/view/home/feed.dart';
import 'package:safespace/view/home/update.dart';
import 'package:safespace/view/resources/app_textstyle.dart';
import 'package:safespace/view/resources/big_primary_button.dart';
import 'package:safespace/view/resources/resources.dart';

import '../../model/city_news_model.dart';
import '../../view-model/fetch_data_vm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                ),
                kSmallVerticalSpacing,
                Text(
                  'Update crime status\naround you',
                  style: heading2(context).copyWith(fontSize: 24),
                ),
                kSmallVerticalSpacing,
                PrimaryButton(
                  press: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => UpdateScreen(id: "",)));
                  },
                  width: MediaQuery.of(context).size.width * 0.4,
                  color: kPrimaryColor,
                  text: Text(
                    'Get started',
                    style: bodyNormalText(context).copyWith(color: kWhiteColor),
                  ),
                ),
                kLargeVerticalSpacing,
                Text(
                  'Crime updates in areas around you',
                  style: heading2(context).copyWith(fontSize: 16),
                ),
                kMediumVerticalSpacing,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        itemCount: cityData.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          // int reversedIndex = snapshot.data!.length - 1 - index;
                          return InkWell(
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => FeedScreen(
                                          cityName: cityData[index].city,
                                          id: cityData[index].id,
                                        )));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 20),
                                decoration:
                                    const BoxDecoration(color: kPrimaryColor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cityData[index].city,
                                      style: bodyNormalText(context).copyWith(
                                          fontSize: 20, color: kWhiteColor),
                                    )
                                  ],
                                ),
                              ));
                        }),
                    // child: FutureBuilder<List<CityNewsModel>>(
                    //     future:
                    //         _fetchData?.getNewsContentsFromDb(context: context),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    //         return ListView.builder(
                    //             itemCount: snapshot.data?.length,
                    //             scrollDirection: Axis.vertical,
                    //             shrinkWrap: true,
                    //             physics: const NeverScrollableScrollPhysics(),
                    //             itemBuilder: (_, index) {
                    //               int reversedIndex =
                    //                   snapshot.data!.length - 1 - index;
                    //               return InkWell(
                    //                   onTap: () async {
                    //                     Navigator.of(context)
                    //                         .push(MaterialPageRoute(
                    //                             builder: (ctx) => FeedScreen(
                    //                                   cityName: snapshot
                    //                                       .data![reversedIndex]
                    //                                       .cityName,
                    //                                   list: snapshot.data!,
                    //                                 )));
                    //                   },
                    //                   child: Container(
                    //                     margin: const EdgeInsets.symmetric(
                    //                         vertical: 12),
                    //                     padding: const EdgeInsets.symmetric(
                    //                         horizontal: 14, vertical: 20),
                    //                     decoration:
                    //                         const BoxDecoration(color: kPrimaryColor),
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           snapshot.data![reversedIndex]
                    //                               .cityName,
                    //                           style: bodyNormalText(context)
                    //                               .copyWith(
                    //                                   fontSize: 20,
                    //                                   color: kWhiteColor),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ));
                    //             });
                    //       } else if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return const Center(
                    //           child: CircularProgressIndicator(
                    //             valueColor: AlwaysStoppedAnimation<Color>(
                    //                 kPrimaryColor),
                    //             strokeWidth: 1,
                    //           ),
                    //         );
                    //       } else {
                    //         return Center(
                    //           child: Text(
                    //             'Somethinng went wrong',
                    //             style: bodySmallText(context),
                    //           ),
                    //         );
                    //       }
                    //     }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
