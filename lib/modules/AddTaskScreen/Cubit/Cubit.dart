import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'State.dart';

class AddTaskScreenCubit extends Cubit<AddTaskScreenStates> {
  AddTaskScreenCubit() : super(AddTaskScreenInitialStates());

  static AddTaskScreenCubit get(context) => BlocProvider.of(context);

  late Database database;

  List<dynamic> tasks = [];

  void createDatabase() {
    openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, date TEXT, description TEXT, status TEXT)')
            .then(
              (value) => print('Table created'),
            )
            .catchError((err) => print("err${err.toString()}"));
      },
      onOpen: (database) {
        GetTasks(database);
      },
    ).then((value) => {
          database = value,
          emit(CreateDatabseState()),
        });
  }

  void GetTasks(database) {
    database.rawQuery('SELECT * FROM Task').then((value) => {
          tasks = [],
          value.forEach((element) {
            tasks.add(element);
          }),
          emit(GetTaskFromDatabase()),
        });
  }

  void insertTask({
    required String title,
    required String description,
    required String status,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Task(title,description,date,status) VALUES("$title","$description","$date","true")')
          .then((value) => {
                GetTasks(database),
                emit(InsertIntoDatabaseState()),
              })
          .catchError((error) {
        print('Error : ${error.toString()}');
      });
      return null;
    });
  }

  void deleteTask({
    required int id,
  }) {
    database
        .rawDelete('DELETE FROM Task WHERE id = $id')
        .then((value) => {
              print('item deleted successfully'),
              GetTasks(database),
              emit(DeleteFromDatabseState()),
            })
        .catchError((error) => print(error));
  }
  
  void updateTask({
  required int id,
  required String title,  
}){
    database.rawUpdate('UPDATE Task SET title = ? where id= ?',['$title',id]).then((value) => {
      print('Item updated successfully'),
      GetTasks(database),
      emit(UpdateTaskToDatabase()),
    }).catchError((error)=>print(error));

  }

  void updateStatus({
  required int id,
  required String status,
}){
    database.rawUpdate('UPDATE Task SET status = ? where id= ?',['$status',id]).then((value) => {
      print('Status updated successfully'),
      GetTasks(database),
      emit(UpdateStatusToDatabase()),
    }).catchError((error)=>print(error));
  }
}
