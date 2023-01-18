import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safespace/view/auth/sign_in.dart';
import 'package:safespace/view/home/home.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../core/prefs.dart';
import '../model/user_model.dart';
import '../shared/dialog.dart';
import '../shared/snackbar.dart';
import '../view/resources/app_colors.dart';

class AuthRepository {
  UserModel? userModel;

  Future<void> createWithEmailAndPwd(
    String userSignUpEmail,
    String userSignUpPassword,
    BuildContext context,
    String fName,
    String lName,
  ) async {
    bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    final UserPreferences _userPreferences =
        Provider.of<UserPreferences>(context, listen: false);
    try {
      if (isConnected == true) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: userSignUpEmail, password: userSignUpPassword);
        await userCredential.user!.sendEmailVerification();
        await FirebaseFirestore.instance
            .collection("UserData")
            .doc(userCredential.user!.uid)
            .set({
          "userId": userCredential.user!.uid,
          "fName": fName,
          "lName": lName,
          "email": userSignUpEmail,
          "password": userSignUpPassword,
          "registrationTime": DateTime.now(),
          "profilePicture": "",
        }).then((value) async {
          await _userPreferences.setIsUserLoggedIn(true);
          await UserPreferences.setProfileData(
            fName,
            lName,
            userSignUpEmail,
            userSignUpPassword,
          );
          await UserPreferences.setProfilePic("");
          print("user is logged in");
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (builder) => const CustomerSignUpSuccess()),
          //     (route) => false);
          showSuccessDialog(
            lottie: '64787-success.json',
            context: context,
            header: "Signup success",
            body: "Yay! Signed up Successfully 🤩",
          );
          // cToast(
          //     msg: "Yay! Signed up Successfully 🤩",
          //     color: kPrimaryColor,
          //     context: context);
        });
      } else {
        showSuccessDialog(
          lottie: 'oops.json',
          context: context,
          header: "Oops! No network connection 😞",
          body: "Go back",
        );
        //  cToast(
        //   msg: "Oops! No network connection 😞",
        //   color: kErrorColor,
        //   context: context);
      }
    } catch (e) {
      print(e.toString());
      showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Oops! An error occured.. 😞",
        body: "Go back",
      );
      // cToast(
      //     msg: "Oops! An error occured.. 😞",
      //     color: kErrorColor,
      //     context: context);
    }
  }

  //Sign In
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    final UserPreferences _userPreferences =
        Provider.of<UserPreferences>(context, listen: false);
    try {
      if (isConnected == true) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          await _userPreferences.setIsUserLoggedIn(true);
          QuerySnapshot userSnapShots =
              await FirebaseFirestore.instance.collection("UserData").get();
          userSnapShots.docs.map((element) {
            if (FirebaseAuth.instance.currentUser!.uid ==
                element.get("userId")) {
              userModel = UserModel(
                fName: element.get("fName") ?? "",
                email: element.get("email") ?? "",
                lName: element.get("lName") ?? "",
                password: element.get("password") ?? "",
                profilePic: element.get("profilePicture"),
              );

              UserPreferences.setProfileData(
                userModel!.fName,
                userModel!.lName,
                userModel!.email,
                userModel!.password,
              );
              UserPreferences.setProfilePic(userModel!.profilePic);
            }
          }).toList();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => const HomeScreen()),
              (route) => false);
          // if (value.user!.emailVerified) {

          // } else {
          //   cToast(
          //       msg: "Email not verified yet",
          //       color: kErrorColor,
          //       context: context);
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (ctx) => const ConfirmEmail()),
          //       (route) => false);
          // }
          return value;
        });
      } else {
        showSuccessDialog(
          lottie: 'oops.json',
          context: context,
          header: "Oops! No network connection",
          body: "Go back",
        );
      }
    } catch (e) {
      print(e.toString());
      showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header:
            "We cannot find an account with this email and password. Please check your details 😞",
        body: "Go back",
      );
    }
  }

  //Sign out
  static Future<void> signOut(BuildContext context) {
    return FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const SignInScreen()),
          (route) => false);
      cToast(msg: "Signed out", color: kPrimaryColor, context: context);
    });
  }

  //Forgot Password
  Future resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      cToast(
          msg: "Password Reset Email sent",
          color: kPrimaryColor,
          context: context);
    } on FirebaseAuthException catch (e) {
      print(e);
      cToast(msg: e.message!, color: kPrimaryColor, context: context);
    }
  }

  //Get User and store to storage
  static Future getUser() async {
    try {
      QuerySnapshot userSnapShots =
          await FirebaseFirestore.instance.collection("UserData").get();
      userSnapShots.docs.map((element) {
        if (FirebaseAuth.instance.currentUser!.uid == element.get("userId")) {
          UserModel? userModel = UserModel(
            fName: element.get("fName") ?? "",
            email: element.get("email") ?? "",
            lName: element.get("lName") ?? "",
            password: element.get("password") ?? "",
            profilePic: element.get("profilePicture"),
          );

          UserPreferences.setProfileData(
            userModel.fName,
            userModel.lName,
            userModel.email,
            userModel.password,
          );
          UserPreferences.setProfilePic(userModel.profilePic);
        }
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }
}
