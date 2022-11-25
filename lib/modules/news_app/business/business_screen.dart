// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/news_cubit/news_cubit.dart';
import 'package:udemy_course/shared/news_cubit/news_states.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          return articleBuilder(list,context);
        });
  }
}
