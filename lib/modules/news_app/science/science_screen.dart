// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/news_cubit/news_cubit.dart';
import '../../../shared/news_cubit/news_states.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var list = NewsCubit.get(context).science;
          return articleBuilder(list,context);
        });
  }
}
