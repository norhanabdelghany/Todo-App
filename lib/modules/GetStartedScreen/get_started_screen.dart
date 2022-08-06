import 'package:flutter/material.dart';
import 'package:todo/modules/TasksScreen/tasks_screen.dart';
import 'package:todo/shared/colors.dart';
import 'package:todo/shared/components.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'Assets/images/IconTask.png',
                ),
                //TODO Task
                Text(
                  'Tasks',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                )
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'Assets/images/AppIcon.png',
              ),
              Text('Welcom to tasks',
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              Text(
                'An application to write your daily personal, work and other tasks',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              CustomButton(
                onPressed: () {
                  navigateAndFinish(context, TasksScreen());
                },
                height: height * 0.06,
                width: width * 0.5,
                color: kButtonBlue,
                raduis: BorderRadius.circular(15),
                text: "Get Started",
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
