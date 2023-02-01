// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:udemy_course/layout/social_app/cubit/social_states.dart';
import 'package:udemy_course/models/social_app/post_model.dart';
import 'package:udemy_course/modules/social_app/comment_details/comment_details.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null,
            builder: (contrext) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(8.0),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQkT5pv_9w_YsKcwVQjS_hNXxxSR-DYNFe6Q&usqp=CAU"),
                              fit: BoxFit.cover,
                              height: 240,
                              width: double.infinity,
                            ),
                            Text(
                              "Communicate with the world",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) => buildPostItem(
                          SocialCubit.get(context).posts[index],
                          context,
                          index,
                        ),
                        itemCount: SocialCubit.get(context).posts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}


Widget buildPostItem(
  PostModel model,
  context,
  index,
) {
  var commentController = TextEditingController();
  return Card(
    color: SocialCubit.get(context).isDark ? HexColor("333739") : Colors.white,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(model.image!),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.name!,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(height: 1.4),
                      ),
                      Spacer(),
                    ],
                  ),
                  Text(
                    model.dateTime!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(height: 1.4, color: Colors.grey),
                  ),
                ],
              )),
              SizedBox(
                width: 15.0,
              ),
              if (model.uId == FirebaseAuth.instance.currentUser!.uid)
                PopupMenuButton(
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      height: 7,
                      onTap: () {},
                      child: TextButton(
                        child: Text('Delete Post'),
                        onPressed: () {
                          var alert = AlertDialog(
                            title: Center(
                              child: Text(
                                'Alert ! ',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            titlePadding: EdgeInsets.all(10),
                            content: SizedBox(
                              width: 150,
                              height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      'Are you sure you want to delete this post ?'),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('NO'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          SocialCubit.get(context).deletepost(
                                              SocialCubit.get(context)
                                                  .postId[index]);
                                          Navigator.pop(context);
                                        },
                                        child: Text('YES'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                          Navigator.pop(context);
                          showDialog(
                              barrierColor: Colors.grey.withOpacity(.6),
                              barrierLabel: 'dsadsasadsadasdasdddsad',
                              context: context,
                              builder: (context) => alert);
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              '${model.text}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    height: 1.4,
                  ),
            ),
          ),
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${model.postImage}')),
                  )),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            SocialCubit.get(context).likes[index].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(height: 1.4, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          navigateTo(context, CommentDetails());
                          SocialCubit.get(context).getPostComments(
                              SocialCubit.get(context).postId[index]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 16,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "comments",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(height: 1.4, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        SocialCubit.get(context).userModel!.image!,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: "wite a comment",
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          if (commentController.text != "") {
                            SocialCubit.get(context).comment(
                              name: SocialCubit.get(context).userModel!.name!,
                              userImage:
                                  SocialCubit.get(context).userModel!.image!,
                              postid: SocialCubit.get(context).postId[index],
                              dateTime: DateTime.now().toString(),
                              userId: SocialCubit.get(context).userModel!.uId!,
                              text: commentController.text,
                            );
                            commentController.text = "";
                          }
                        },
                        child: Icon(IconBroken.Send)),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  SocialCubit.get(context)
                      .likePost(SocialCubit.get(context).postId[index]);
                },
                child: Icon(
                  IconBroken.Heart,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
