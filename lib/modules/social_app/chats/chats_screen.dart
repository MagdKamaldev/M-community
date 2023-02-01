// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/models/social_app/social_user_model.dart';
import 'package:udemy_course/modules/social_app/chat_details/chat_details.dart';
import 'package:udemy_course/shared/components/components.dart';
import '../../../layout/social_app/cubit/social_cubit.dart';
import '../../../layout/social_app/cubit/social_states.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(SocialCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(context,ChatDetailsScreen(userModel: model,));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(model.image!),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                model.name!,
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
        ),
      );
}
