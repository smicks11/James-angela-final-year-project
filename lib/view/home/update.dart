// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safespace/shared/texfield.dart';
import 'package:safespace/view/resources/big_primary_button.dart';
import '../../model/city_news_model.dart';
import '../../shared/bottom_sheet.dart';
import '../../view-model/fetch_data_vm.dart';
import '../resources/app_textstyle.dart';
import '../resources/resources.dart';
import 'component/feed_block.dart';
import 'feed.dart';

class UpdateScreen extends StatefulWidget {
  final String id;
  UpdateScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  FetchData? _fetchData;
  final TextEditingController textCtrl = TextEditingController();
  bool isLoadingModal = false;

  @override
  void didChangeDependencies() {
    _fetchData = Provider.of<FetchData>(context, listen: false);
    // Provider.of<FetchData>(context, listen: false)
    //     .fetchPodcast(context: context);
    super.didChangeDependencies();
  }

  // final ReviewRepository _reviewRepository = ReviewRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            kTinyVerticalSpacing,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: SingleChildScrollView(
                  child:  ListView.builder(
                        itemCount: cityData.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          // int reversedIndex = snapshot.data!.length - 1 - index;
                          return InkWell(
                              onTap: () async {
                                 _updateSheet(
                                          context,
                                          _fetchData!,
                                          cityData[index].id,
                                          "");
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (ctx) => FeedScreen(
                                //           cityName: cityData[index].city,
                                //           id: cityData[index].id,
                                //         )));
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
                  //         _fetchData?.getNewsContentsFromDb(context: context, id: widget.id),
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
                  //                     _updateSheet(
                  //                         context,
                  //                         _fetchData!,
                  //                         snapshot
                  //                             .data![reversedIndex].cityName,
                  //                         "");
                  //                   },
                  //                   child: Container(
                  //                     margin: const EdgeInsets.symmetric(
                  //                         vertical: 12),
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 14, vertical: 20),
                  //                     decoration:
                  //                         BoxDecoration(color: kPrimaryColor),
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Text(
                  //                           snapshot
                  //                               .data![reversedIndex].cityName,
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
                  //             valueColor:
                  //                 AlwaysStoppedAnimation<Color>(kPrimaryColor),
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
              ),
            )
          ],
        ),
      )),
    );
  }

  _updateSheet(
    // RescheduleAppointmentViewModel model,
    BuildContext ctx,
    FetchData data,
    String cityId,
    String user,
  ) {
    // Initial Selected Value

    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (ctx) => StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
              return ActionBottomSheet(
                children: [
                  kMediumVerticalSpacing,
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        'Post news',
                        style: bodyNormalText(context)
                            .copyWith(color: kPrimaryColor, fontSize: 16),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 22,
                          )),
                      //        HSpace(
                      //   24.w,
                      // ),
                    ],
                  ),
                  kLargeVerticalSpacing,
                  Field(
                    textInputAction: TextInputAction.done,
                    keyType: TextInputType.text,
                    controller: textCtrl,
                    hintText: "Enter crime report",
                    func: () {},
                    minLines: 6,
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'This field is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kLargeVerticalSpacing,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryButton(
                        width: MediaQuery.of(context).size.width * 1.0,
                        press: () async {
                          stateSetter(() {
                            isLoadingModal = true;
                          });
                          await data.updateContent(
                              context: ctx,
                              cityId: cityId,
                              news: textCtrl.text,
                              user: "Anonymous");
                          stateSetter(() {
                            isLoadingModal = false;
                          });
                          textCtrl.clear();
                          Navigator.pop(ctx);
                        },
                        text: isLoadingModal == true
                            ? Text(
                                'Processing... please wait...',
                                style: bodySmallText(context)
                                    .copyWith(color: kWhiteColor),
                              )
                            : Text(
                                'Post News',
                                style: bodySmallText(context)
                                    .copyWith(color: kWhiteColor),
                              )),
                  )
                ],
              );
            }));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text("Upload feed on a city",
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
