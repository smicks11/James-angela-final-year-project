import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safespace/view/resources/app_colors.dart';
import 'package:safespace/view/resources/app_textstyle.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;
  const SplashScreen({Key? key, required this.nextScreen}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => widget.nextScreen));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      'Safe Space',
      style: heading1(context).copyWith(color: kPrimaryColor, fontSize: 22),
    )));
  }
}
