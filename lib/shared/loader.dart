 import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../view/resources/app_colors.dart';
import '../view/resources/app_spacing.dart';
import '../view/resources/app_textstyle.dart';

showLoaderDialog({required BuildContext context, required String text, String? loadingText}) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const SizedBox(
            height: 30,
            width: 30,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                strokeWidth: 2,
              ),
            ),
          ),
          const SizedBox(width: 5,),
          Container(
              margin: const EdgeInsets.only(left: 7), child: Text(text, style: bodySmallText(context),)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
showVerticalLoaderDialog({required BuildContext context, required String text}) {
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         Center(
                      child: Container(
                        child: Lottie.asset(
                          'assets/lottie/logo_loader.json',
                          height: 100.0,
                          repeat: true,
                          reverse: true,
                          animate: true,
                        ),
                      ),
                    ),
          kMediumVerticalSpacing,
          Container(
              margin: const EdgeInsets.only(left: 7), child: Text(text, style: bodySmallText(context),)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
