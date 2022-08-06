import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo/modules/GetStartedScreen/get_started_screen.dart';
import 'package:todo/shared/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AnimatedSplashScreen(
      duration: 4000,
      splash: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'Assets/images/IconTask.png',
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            'Tasks',
            style: TextStyle(color: Colors.white, fontSize: 50),
          )
        ],
      ),
      nextScreen: GetStartedScreen(),
      centered: true,
      splashIconSize: double.infinity,
      backgroundColor: kPrimaryBlue,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
