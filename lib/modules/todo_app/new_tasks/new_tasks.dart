// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_cubit.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_states.dart';
import '../../../shared/components/components.dart';


class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}
