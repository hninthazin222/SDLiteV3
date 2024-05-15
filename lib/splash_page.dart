import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sdlite/Verify/signin_page.dart';
import 'package:sdlite/style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var token;

  route() {
    // if (token == null) {
    //   return Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const SignInPage(),
    //     ),
    //   );
    // } else {
    //   return Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const HomePage(),
    //     ),
    //   );
    // }
    print(">>>>>>>2");
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ),
    );
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  @override
  void initState() {
    print(">>>>>>>1");
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: mainColor,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Image.asset(
            "assets/images/splash.png",
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
