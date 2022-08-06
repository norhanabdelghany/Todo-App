import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/modules/AddTaskScreen/Cubit/Cubit.dart';
import 'package:todo/modules/AddTaskScreen/Cubit/State.dart';
import 'package:todo/shared/colors.dart';
import 'package:date_time_picker/date_time_picker.dart';

import '../../shared/components.dart';

class AddTaskScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AddTaskScreenCubit, AddTaskScreenStates>(
        listener: (context, state) {
      if (state is InsertIntoDatabaseState) {
        Fluttertoast.showToast(
            msg: "Task added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }


    }, builder: (context, state) {
      AddTaskScreenCubit cubit = AddTaskScreenCubit.get(context);
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: kPrimaryBlue,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Add Tasks",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    CustomItem(
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
                    SizedBox(
                      height: 10,
                    ),
                    CustomItem(
                      controller: dateController,
                      labelText: 'Date',
                      InputTextStyle: TextStyle(
                        color: kWhite,
                      ),
                      isEnabled: true,
                      labelStyle: TextStyle(color: kOrange, fontSize: 20),
                      borderRadius: BorderRadius.circular(20),
                      backgroundColor: kPrimaryBlue,
                      borderColor: kBrown,
                      hintText: "Please enter the date",
                      hintStyle: TextStyle(color: kWhite),
                      suffixIcon: DateTimePicker(
                        initialValue: 'Enter date',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        onSaved: (val) {
                          dateController.text = val.toString();
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.calendar_month, color: kWhite),
                          ),
                        ),
                      ),
                      validate: (String? val) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomItem(
                      controller: descriptionController,
                      labelText: 'Description',
                      labelStyle: TextStyle(color: kOrange, fontSize: 20),
                      borderRadius: BorderRadius.circular(20),
                      backgroundColor: kWhite,
                      borderColor: kBrown,
                      hintText: "Please enter description",
                      hintStyle: TextStyle(color: kBlack),
                      maxLines: 15,
                      validate: (String? val) {
                        if (val!.isEmpty) return "Please enter description";
                      },
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.insertTask(
                                title: titleController.text,
                                description: descriptionController.text,
                                status: 'false',
                                date: DateTime.now().toString(),
                            );
                          }
                        },
                        color: kButtonBlue,
                        height: height * 0.06,
                        width: width * 0.5,
                        raduis: BorderRadius.circular(15),
                        text: "Add tasks",
                        textColor: kWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
