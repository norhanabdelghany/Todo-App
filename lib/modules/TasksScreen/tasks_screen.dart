import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/modules/AddTaskScreen/Cubit/Cubit.dart';
import 'package:todo/modules/AddTaskScreen/Cubit/State.dart';
import 'package:todo/modules/AddTaskScreen/add_task_screen.dart';
import 'package:todo/shared/colors.dart';
import 'package:todo/shared/components.dart';

class Item {
  String title;
  Item({
    required this.title,
  });
}

class TasksScreen extends StatelessWidget {
  bool value = false;
  var titleController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<Item> items = [Item(title: 'Learn HTMl')];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AddTaskScreenCubit, AddTaskScreenStates>(
      listener: (context, state) {
        if (state is InsertIntoDatabaseState) {
          navigateTo(context, TasksScreen());
        }
        if (state is DeleteFromDatabseState) {
          Fluttertoast.showToast(
              msg: "Task deleted successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        if (state is UpdateTaskToDatabase) {
          Fluttertoast.showToast(
              msg: "Task updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.yellow,
              textColor: kPrimaryBlue,
              fontSize: 16.0
          );
        }
      },
      builder: (context, state) {
        AddTaskScreenCubit cubit = AddTaskScreenCubit.get(context);
        return Scaffold(
          backgroundColor: kLightGrey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, AddTaskScreen());
            },
            backgroundColor: kPrimaryBlue,
            child: Image.asset("Assets/images/addIcon.png"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                          alignment: Alignment.center,
                          width: width * 0.8,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryBlue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Simply control your time",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  )),
                              Image.asset("Assets/images/AppIcon.png"),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tasks",
                      style: TextStyle(color: kPrimaryBlue, fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width ,
                      height: height * 0.8,
                      child: Center(
                        child: ListView.separated(
                            itemBuilder: (context, index) => TaskItem(
                                  taskTitle: cubit.tasks[index]['title'],
                                  active:  cubit.tasks[index]['status'] == 'true'?true:false ,
                                  onChange: (bool? value) {
                                          cubit.updateStatus(id: cubit.tasks[index]['id'], status: value.toString());

                                  },
                                  onDelete: () {
                                    cubit.deleteTask(id: cubit.tasks[index]['id']);
                                  },
                                  onEdit: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.QUESTION,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Task',

                                      body: Form(
                                        key: formKey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CustomItem(
                                            InputTextStyle: TextStyle(color: kWhite),
                                            controller: titleController,
                                            labelText: 'Title',
                                            labelStyle: TextStyle(color: kOrange, fontSize: 20),
                                            borderRadius: BorderRadius.circular(20),
                                            backgroundColor: kPrimaryBlue,
                                            hintText: 'Please enter title',
                                            hintStyle: TextStyle(color: kWhite),
                                            borderColor: kBrown,
                                            prefixIcon: Icon(
                                              Icons.task,
                                              color: kWhite,
                                            ),
                                            validate: (String? val) {
                                              if (val!.isEmpty) return "Please enter title";
                                            },
                                          ),
                                        ),
                                      ),
                                      desc:
                                      'Title : ${cubit.tasks[index]['title']} \n Description: ${cubit.tasks[index]['description']} \n Date: ${cubit.tasks[index]['date']}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        if(formKey.currentState!.validate()){
                                          cubit.updateTask(id: cubit.tasks[index]['id'], title: titleController.text,);
                                        }
                                      },
                                    ).show();
                                  },
                                  onView: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.SUCCES,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Task',
                                      desc:
                                          'Title : ${cubit.tasks[index]['title']} \n Description: ${cubit.tasks[index]['description']} \n Date: ${cubit.tasks[index]['date']}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  },
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 8,
                                ),
                            itemCount: cubit.tasks.length),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
