// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/news_app/search/search_screen.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/news_cubit/news_cubit.dart';
import 'package:udemy_course/shared/news_cubit/news_states.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("NEWS APP"),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: "Business"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports), label: "Sports"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science), label: "Science"),
            ],
          ),
        );
      },
    );
  }
}
