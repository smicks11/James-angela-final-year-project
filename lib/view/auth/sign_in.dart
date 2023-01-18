// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safespace/view/auth/sign_up.dart';
import '../../view-model/auth_vm.dart';
import '../resources/app_textstyle.dart';
import '../resources/back_button.dart';
import '../resources/big_primary_button.dart';
import '../resources/resources.dart';
import 'forgot_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

bool obserText = true;

class _SignInScreenState extends State<SignInScreen> {
  bool _loading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();

  bool _validatePwd = false;
  bool _validateEmail = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String pText = "Password should be a minimum of 8 chars";
    String eText = "Email can't be empty";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                    kMediumVerticalSpacing,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPad),
                      child: Text("Sign In",
                          style: heading1(context).copyWith(
                            color: kPrimaryColor,
                            fontSize: 30,
                          )),
                    ),
                    kMediumVerticalSpacing,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            style: bodySmallText(context),
                            controller: _emailController,
                            validator: (value) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = RegExp(pattern.toString());
                              if (!regex.hasMatch(value!)) {
                                return 'Invalid email address';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Your email",
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                                  // fontFamily: "Booing",
                                  ),
                              errorStyle: TextStyle(
                                fontSize: 10,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(kPad - 10),
                                  borderSide:
                                      BorderSide(color: kTextFieldFillColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(kPad - 10),
                                  borderSide:
                                      BorderSide(color: kTextFieldFillColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(kPad - 10),
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(kPad - 10),
                                  borderSide:
                                      BorderSide(color: kTextFieldFillColor)),
                            ),
                          ),
                          kLargeVerticalSpacing,
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.length < 8) {
                                return 'Password cannot be less than 8 characters';
                              } else {
                                return null;
                              }
                            },
                            obscureText: obserText,
                            decoration: InputDecoration(
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obserText = !obserText;
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                child: Text(
                                  obserText == true ? "Show" : "Hide",
                                ),
                              ),
                              hintText: "Enter password",
                              hintStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                                  // fontFamily: "Booing",
                                  ),
                              errorStyle: TextStyle(
                                fontSize: 10,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(kPad - 10),
                                  borderSide:
                                      BorderSide(color: kTextFieldFillColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(kPad - 10),
                                  borderSide:
                                      BorderSide(color: kTextFieldFillColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(kPad - 10),
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(kPad - 10),
                                  borderSide:
                                      BorderSide(color: kTextFieldFillColor)),
                            ),
                          ),
                          kLargeVerticalSpacing,
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => ForgotPassword()));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot password ",
                                style: bodySmallText(context).copyWith(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    // Spacer(),
                    Center(
                        child: PrimaryButton(
                      color: _loading == true
                          ? kPrimaryColor.withOpacity(0.4)
                          : kPrimaryColor,
                      text: _loading == true
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kWhiteColor),
                                  strokeWidth: 1,
                                ),
                              ),
                            )
                          : Text(
                              "Sign in",
                              style: labelText(context)
                                  .copyWith(color: kWhiteColor, fontSize: 14),
                            ),
                      textColor: kWhiteColor,
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          await Future.value(_authRepository.signInWithEmail(
                              _emailController.text,
                              _passwordController.text,
                              context));
                          setState(() {
                            _loading = false;
                          });
                        }
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: bodySmallText(context).copyWith(
                              color: kBlackColor,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => SignUp()));
                            },
                            child: Text(
                              "Sign Up",
                              style: bodySmallText(context)
                                  .copyWith(color: kPrimaryColor),
                            ))
                      ],
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
          kSmallVerticalSpacing,
        ],
      )),
    );
  }
}
