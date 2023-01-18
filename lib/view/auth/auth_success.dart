// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:safespace/view/home/home.dart';
import '../resources/app_textstyle.dart';
import '../resources/back_button.dart';
import '../resources/big_primary_button.dart';
import '../resources/resources.dart';

class AuthSuccess extends StatelessWidget {
  const AuthSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                    kMediumVerticalSpacing,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPad),
                      child: Text("Yay \nRegistration\ncompleted!",
                          style: heading1(context).copyWith(
                            color: kPrimaryColor,
                            fontSize: 30,
                          )),
                    ),
                    kSmallVerticalSpacing,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPad),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " In order to LOVE who you are, you cannot hate the experiences that shaped you.",
                            style: bodyTinyText(context)
                                .copyWith(color: Colors.white30),
                          ),
                          kMediumVerticalSpacing,
                          Center(
                            child: Container(
                              child: Lottie.asset(
                                'assets/lottie/64787-success.json',
                                height: 200.0,
                                repeat: true,
                                reverse: true,
                                animate: true,
                              ),
                            ),
                          ),
                          kLargeVerticalSpacing,
                          Center(
                            child: PrimaryButton(
                              text: Text(
                                "Check out ongoing crimes around you",
                                style: labelText(context)
                                    .copyWith(color: kWhiteColor, fontSize: 14),
                              ),
                              textColor: kWhiteColor,
                              press: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => HomeScreen()));
                              },
                              width: MediaQuery.of(context).size.width * 0.9,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Center(
            //     child: Image(
            //   image: AssetImage('assets/images/zen_logo.png'),
            //   height: 70,
            //   fit: BoxFit.cover,
            // )),
            kSmallVerticalSpacing,
          ],
        ),
      ),
    );
  }
}
