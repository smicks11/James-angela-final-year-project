// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:safespace/view/auth/auth_success.dart';
import '../../shared/loader.dart';
import '../../view-model/auth_vm.dart';
import '../resources/app_textstyle.dart';
import '../resources/back_button.dart';
import '../resources/big_primary_button.dart';
import '../resources/resources.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

bool obserText = true;
bool obserTextTwo = true;

RegExp regExp = new RegExp(p);
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String errorText = "Please enter vald email address";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
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
                      padding: const EdgeInsets.symmetric(horizontal: kPad),
                      child: Text("Sign Up",
                          style: heading1(context).copyWith(
                            color: kPrimaryColor,
                            fontSize: 30,
                          )),
                    ),
                    kMediumVerticalSpacing,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: bodySmallText(context),
                                controller: _firstNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Kinldy enter a valid name';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: _firstNameController
                                              .text.length !=
                                          null
                                      ? Padding(
                                          padding: EdgeInsets.all(kPad - 5),
                                          child: GestureDetector(
                                            onTap: () =>
                                                _firstNameController.clear(),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black12,
                                                ),
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 8,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        )
                                      : null,
                                  hintText: "First Name",
                                  hintStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12
                                      // fontFamily: "Booing",
                                      ),
                                  errorStyle: TextStyle(
                                    fontSize: 10,
                                  ),
                                  border: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                  enabledBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                  focusedBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  errorBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                ),
                              ),
                              kLargeVerticalSpacing,
                              TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: bodySmallText(context),
                                controller: _lastNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Kinldy enter a valid name';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon:
                                      _lastNameController.text.length != null
                                          ? Padding(
                                              padding: EdgeInsets.all(kPad - 5),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    _lastNameController.clear(),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.black12,
                                                    ),
                                                    child: Icon(
                                                      Icons.clear,
                                                      size: 8,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            )
                                          : null,
                                  hintText: "Last Name",
                                  hintStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12
                                      // fontFamily: "Booing",
                                      ),
                                  errorStyle: TextStyle(
                                    fontSize: 10,
                                  ),
                                  border: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                  enabledBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                  focusedBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  errorBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                ),
                              ),
                              kLargeVerticalSpacing,
                              TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: bodySmallText(context),
                                controller: _emailController,
                                textInputAction: TextInputAction.next,
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
                                  suffixIcon:
                                      _emailController.text.length != null
                                          ? Padding(
                                              padding: EdgeInsets.all(kPad - 5),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    _emailController.clear(),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.black12,
                                                    ),
                                                    child: Icon(
                                                      Icons.clear,
                                                      size: 8,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            )
                                          : null,
                                  hintText: "Email Address",
                                  hintStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12
                                      // fontFamily: "Booing",
                                      ),
                                  errorStyle: TextStyle(
                                    fontSize: 10,
                                  ),
                                  border: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                  enabledBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                  focusedBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  errorBorder: UnderlineInputBorder(
                                      // borderRadius: BorderRadius.circular(kPad - 10),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1))),
                                ),
                              ),
                              kLargeVerticalSpacing,
                              TextFormField(
                                validator: (value) {
                                  if (value!.length < 8) {
                                    return 'Password cannot be less than 8 characters';
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(
                                  color: kBlackColor,
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: obserText,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(kPad - 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kWhiteColor.withOpacity(0.1),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obserText = !obserText;
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: Icon(
                                          obserText == true
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: kBlackColor,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12
                                      // fontFamily: "Booing",
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: kBlackColor.withOpacity(0.1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPrimaryColor),
                                  ),
                                  hintText: "Your Password",
                                ),
                              ),
                              kLargeVerticalSpacing,
                              TextFormField(
                                validator: (value) {
                                  print(value);
                                  if (value!
                                      .contains(_passwordController.text)) {
                                    return null;
                                  } else {
                                    return 'Password does not match';
                                  }
                                },
                                style: TextStyle(
                                  color: kBlackColor,
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: obserTextTwo,
                                controller: _confirmPasswordController,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(kPad - 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kWhiteColor.withOpacity(0.1),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obserTextTwo = !obserTextTwo;
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: Icon(
                                          obserTextTwo == true
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: kBlackColor,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12
                                      // fontFamily: "Booing",
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: kBlackColor.withOpacity(0.1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPrimaryColor),
                                  ),
                                  hintText: "Confirm Password",
                                ),
                              ),
                              kLargeVerticalSpacing,
                            ],
                          ),
                        ),
                      ),
                    ),
                    kLargeVerticalSpacing,
                    Center(
                      child: PrimaryButton(
                        text: _loading == true
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kWhiteColor),
                                    strokeWidth: 1,
                                  ),
                                ),
                              )
                            : Text(
                                "Complete sign up",
                                style: labelText(context)
                                    .copyWith(color: kWhiteColor, fontSize: 14),
                              ),
                        textColor: kWhiteColor,
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            showLoaderDialog(
                                context: context, text: "Creating account...");
                            await Future.value(
                                _authRepository.createWithEmailAndPwd(
                                    _emailController.text,
                                    _passwordController.text,
                                    context,
                                    _firstNameController.text,
                                    _lastNameController.text));
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AuthSuccess()));
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ),
                    kMediumVerticalSpacing,
                    // Spacer(),

                    // Spacer()
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
