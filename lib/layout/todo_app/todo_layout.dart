// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, unused_local_variable, must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_cubit.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_states.dart';

class TodoLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Center(child: const Text("TO-DO")),
            ),
            body: ConditionalBuilder(
              builder: (context) => cubit.screens[cubit.currentIndex],
              condition: state is! AppGetDataBaseLoadingState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDataBase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  onSubmit: () {},
                                  onChanged: () {},
                                  onTab: () {},
                                  controller: titleController,
                                  type: TextInputType.text,
                                  label: "Task Title",
                                  prefix: Icons.title,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "title must not be empty";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  onSubmit: () {},
                                  onChanged: () {},
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  label: "Task Time",
                                  onTab: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  prefix: Icons.watch_later_outlined,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "time must not be empty";
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  onSubmit: () {},
                                  onChanged: () {},
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  label: "Task Date",
                                  onTab: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2022-12-01"),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  prefix: Icons.calendar_today,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "date must not be empty";
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShown: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShown: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.check_circle_outline),
                    label: "Done"),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.archive_outlined),
                    label: "Archived"),
              ],
            ),
          );
        },
      ),
    );
  }
}
