import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../view/resources/app_colors.dart';
import '../view/resources/app_textstyle.dart'; 

cToast(
    {required String msg,
    required Color color,
    required BuildContext context}) {
  showTopSnackBar(
    context,
    CustomSnackBar.success(
      iconPositionLeft: 8,
      textStyle: bodySmallText(context).copyWith(color: kWhiteColor),
      message: msg,
      backgroundColor: color,
      icon: const Icon(Icons.info, color: kWhiteColor),
    ),
  );
}