// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String onboardingRoute = "/onboarding";
  static const String registerRoute = "/register";
  static const String homeRoute = "/home";
  static const String pageViewRoute = "/pageView";
  static const String welcomeRoute = "/welcome";
  static const String signInRoute = "/signIn";
  static const String signUpEmailRoute = "/signUpEmail";
  static const String nameRoute = "/name";
  static const String passwordRoute = "/password";
  static const String authSuccessRoute = "/authSuccess";
  static const String viewVideosRoute = "/viewVideos";
  static const String entryAnswer = "/entryAnswer";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case Routes.splashRoute:
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (ctx) => const Scaffold(
              body: Center(
                child: Text("Oops seems you are lost, kindly restart the app!"),
              ),
            ));
  }
}
