// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../view-model/auth_vm.dart';
import '../resources/app_textstyle.dart';
import '../resources/back_button.dart';
import '../resources/big_primary_button.dart';
import '../resources/form_build.dart';
import '../resources/resources.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

RegExp regExp = new RegExp(p);
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool _validateEmail = false;
  bool _loadingState = false;

  final authRepository = AuthRepository();
  final Duration initialDelay = const Duration(milliseconds: 2);
  @override
  Widget build(BuildContext context) {
    String incorrectEmail = "Please enter a valid email";
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBackButton(),
           Padding(
                padding: EdgeInsets.symmetric(horizontal: kPad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Reset your\npassword",
                        style: heading1(context).copyWith(
                          color: kBlackColor,
                          fontSize: 25,
                        )),
                    // kTinyVerticalSpacing,
                    // Text("Reset your password now!",
                    //     style: bodyTinyText(context).copyWith()),
                  ],
                ),
              ),
            kLargeVerticalSpacing,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPad),
              child: Text(
                  " Email your registered Email Address",
                  style: bodyTinyText(context),
                ),
            ),
            kTinyVerticalSpacing,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPad),
              child:FormBuild(
                  validator: (value) {},
                  controller: _emailController,
                  labelText: "Email Address",
                  icon: Icons.clear,
                  errorText: _validateEmail == true ? null : incorrectEmail,
                  onChanged: (value) {
                    value = _emailController.text;
                    setState(() {
                      if (value.isEmpty || !regExp.hasMatch(value)) {
                        _validateEmail = false;
                      } else {
                        _validateEmail = true;
                      }
                    });
                  },
                ),
            ),
            const Spacer(),
            Center(
                child: ShowLoaderButton(
              // color: _loadingState == true
              //     ? kPrimaryColor.withOpacity(0.6)
              //     : kPrimaryColor,
              placeHolder: _loadingState == true
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kWhiteColor),
                          strokeWidth: 1,
                        ),
                      ),
                    )
                  : Text(
                      "Proceed",
                      style: labelText(context).copyWith(color: kWhiteColor),
                    ),
              press: _validateEmail == true
                  ? () async {
                      setState(() {
                        _loadingState = true;
                      });
                      await Future.value(authRepository.resetPassword(
                          _emailController.text.trim(), context));
                      setState(() {
                        _loadingState = false;
                      });
                    }
                  : () {},
              width: MediaQuery.of(context).size.width * 0.9,
            )),
            kMediumVerticalSpacing,
            Center(
                child: Image(
              image: AssetImage('assets/images/zen_logo.png'),
              height: 70,
              fit: BoxFit.cover,
            )),
            kSmallVerticalSpacing,
          ],
        ),
      ),
    );
  }
}
