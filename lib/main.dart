import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/HomeScreen/home_screen.dart';
import 'package:todo/modules/TasksScreen/tasks_screen.dart';

import 'modules/AddTaskScreen/Cubit/Cubit.dart';
import 'modules/AddTaskScreen/add_task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddTaskScreenCubit()..createDatabase(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Jannah'
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
