// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/models/social_app/comment_model.dart';
import 'package:udemy_course/shared/components/components.dart';
import '../../../layout/social_app/cubit/social_cubit.dart';
import '../../../layout/social_app/cubit/social_states.dart';

class CommentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<CommentModel> comments = SocialCubit.get(context).postComments;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(context: context, title: "Comments"),
          body: (comments.isEmpty)
              ? Center(
                  child: Text(
                    "No comments yet !",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) =>
                      commentItem(comments[index], context),
                  itemCount: comments.length,
                ),
        );
      },
    );
  }

  Widget commentItem(model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(model.userImage),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  model.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(height: 1.4),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        const BorderRadiusDirectional.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(child: Text(model.text)),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        model.dateTime,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
