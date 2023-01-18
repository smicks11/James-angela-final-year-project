import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../model/city_news_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_spacing.dart';
import '../../resources/app_textstyle.dart';

class FeedbackBlock extends StatelessWidget {
  final String news;
  final String user;
  final DateTime time;
  // List<CityNewsModel> list;
   FeedbackBlock({
    Key? key,
    required this.news,
    required this.user,
    required this.time,
    // required this.list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kTextFieldFillColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 15,
                          backgroundColor: kPrimaryColor,
                          child: Text(''),
                        ),
                        kTinyHorizontalSpacing,
                        Expanded(
                            child: Text(
                          'By $user',
                          style: bodySmallText(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                        Icon(
                          Icons.emoji_emotions_outlined,
                          color: kPrimaryColor,
                          size: 20,
                        )
                      ],
                    ),
                    kSmallVerticalSpacing,
                    Text(news)
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          timeago.format(time),
                          style: bodySmallText(context)
                              .copyWith(color: Colors.black26),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
