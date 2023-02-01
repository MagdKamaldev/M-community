// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names, duplicate_ignore, prefer_const_literals_to_create_immutables
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:udemy_course/layout/social_app/cubit/social_states.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/styles/icon_broken.dart';

import '../../modules/Social_app/new_post/new_post.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconBroken.Video,
                    color: Colors.red,
                  )),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null,
            builder: (context) {
              return cubit.screens[cubit.currentIndex];
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: "chats"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: "Post"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: "Map"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: "Settings"),
            ],
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
