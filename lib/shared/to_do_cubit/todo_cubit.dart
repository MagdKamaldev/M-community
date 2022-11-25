// ignore_for_file: unnecessary_string_interpolations, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/shared/networks/local/cache_helper.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_states.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/todo_app/archived_tasks/archived_tasks.dart';
import '../../modules/todo_app/done_tasks/done_tasks.dart';
import '../../modules/todo_app/new_tasks/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDataBase() {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database, version) {
        database.execute(
            "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)");
      },
      onOpen: (database) {
        getDataFromDataBase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertToDataBase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database?.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        emit(AppInsertDataBaseState());
        getDataFromDataBase(database);
      });
    });
  }

  void getDataFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDataBaseLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element["status"] == "new")
          newTasks.add(element);
        else if (element["status"] == "done")
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDataBaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database?.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShown,
    required IconData icon,
  }) {
    isBottomSheetShown = isShown;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null)
      isDark = fromShared;
    else {
      isDark = !isDark;
      CacheHelper.putBool(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
