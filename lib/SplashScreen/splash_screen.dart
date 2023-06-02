import 'dart:async';
import 'package:flutter/material.dart';

import '../Authentication/Login.dart';
import '../Global/global.dart';

import '../MainScreen/main_screen.dart';
import '../Assistant_Methods/asssistant_methods.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
          fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;
    Timer(const Duration(seconds: 3), () async {

      // *** Condition *****//
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) =>  MainScreen()));
      } else {
        //***********SEND USER TO MainSceen after some Seconds*******/
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "My Captain",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
