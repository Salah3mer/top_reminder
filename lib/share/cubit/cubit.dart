import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_reminder/sceens/add/add.dart';
import 'package:top_reminder/sceens/done/done_screen.dart';
import 'package:top_reminder/sceens/tasks/task_screen.dart';
import 'package:top_reminder/share/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int CurrantIndex =0;
  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];

  List<String> titles = [
    'My Note',
    'New Tasks',
    'Done Tasks',
  ];
  int colorIndex=0;

  List<Color> colors = [
    Colors.lightBlue[100],
    Colors.teal[100],
    Colors.pink[100],
    Colors.amberAccent[100],
    Colors.indigo[100],
    Colors.orange[100],
    Colors.deepPurple[100],
    Colors.lightGreen[200],
  ];

  List<Widget> screen=[
    task_screen(),
    add_Screen(),
    done_screen(),

  ];

  void CreateDatabase() {
    openDatabase('Note.db', version: 1, onCreate: (database, version) {
      print('Database Created');
      database
          .execute(
              'CREATE TABLE note (id INTEGER  PRIMARY KEY,title TEXT ,task TEXT,date TEXT,time TEXT, color INTEGER, state TEXT)')
          .then((value) {
        print('Table Created ');
      }).catchError((error) {
        print('error When Create Table ${error.toString()}');
      });
    }, onOpen: (database) {
      print('Database Open');
      GetFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreatDatabase());
    });
  }

  Future InsertToDatabase(
      {@required String title,
      @required String task,
      @required String date,
      @required String time,
     }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO note (title , task , date ,time ,color ,state) VALUES ("$title","$task","$date","$time",$colorIndex,"New")')
          .then((value) {
        print('Row Inserted Successfully');
        emit(AppInsertToDatabase());
        GetFromDatabase(database);
      }).catchError((error) {
        print('Error when insert ${error.toString()}');
      });
      return null;
    });
  }

  void GetFromDatabase(database) {
    doneTasks = [];
    newTasks = [];

    database.rawQuery('SELECT * FROM note').then((value) {
      value.forEach((element) {
        if (element['state'] == 'New')
          newTasks.add(element);
        else
          doneTasks.add(element);
      });
      emit(AppGetDatabase());
    });
  }

  void UpdateDatabase(@required String state, @required int id) {
    database.rawUpdate('UPDATE note SET state = ? WHERE id = ?',
        ['${state}', id]).then((value) {
      GetFromDatabase(database);
      emit(AppUpdateDatebase());
    });
  }

  void deletefromDatabase(
      @required int id
      ){
    database.rawDelete('DELETE FROM note WHERE id = ?', [id]).then((value) {
      GetFromDatabase(database);
      emit(AppDeleteDatabase());
    });
  }

  void ButtonNavBar(int index){
    CurrantIndex=index;
    emit(ButtonNavBarState());

  }

  void changeColorIndex(int index){
    colorIndex=index;
    emit(ColorState());

  }
}
