// ignore_for_file: use_key_in_widget_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:udemy_course/layout/social_app/cubit/social_states.dart';
import 'package:udemy_course/modules/social_app/edit_profile/edit_profile.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/styles/icon_broken.dart';

import '../../../models/social_app/post_model.dart';
import '../../../shared/networks/local/cache_helper.dart';

class PorfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image:
                                    NetworkImage(userModel!.cover.toString()),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(userModel.image.toString()),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  userModel.name.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  userModel.bio.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(height: 1.4, color: Colors.grey, fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              SocialCubit.get(context)
                                  .userPosts
                                  .length
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(height: 1.4, fontSize: 20),
                            ),
                            Text(
                              "posts",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      height: 1.4,
                                      color: Colors.grey,
                                      fontSize: 14),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
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
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        child: const Text("Chats"),
                        onPressed: () {
                          SocialCubit.get(context).gotoChats();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      child: const Icon(
                        IconBroken.Edit,
                        size: 16,
                      ),
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
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
                const SizedBox(
                  height: 30,
                ),
                SocialCubit.get(context).userPosts.isNotEmpty
                    ? ConditionalBuilder(
                        builder: (context) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) =>
                                buildProfilePostItem(
                              SocialCubit.get(context).userPosts[index],
                              context,
                              index,
                            ),
                            itemCount:
                                SocialCubit.get(context).userPosts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          );
                        },
                        condition:
                            State is! SocialGetSingleUserPostLoadingState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Text(
                        "No Posts Yet !",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(height: 1.4, fontSize: 20),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildProfilePostItem(
  PostModel model,
  context,
  index,
) {
  var commentController = TextEditingController();
  return Card(
    color:
        CacheHelper.getData(key: "isDark") ? HexColor("333739") : Colors.white,
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
              const SizedBox(
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
                      const Spacer(),
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
              const SizedBox(
                width: 15.0,
              ),
              if (model.uId == FirebaseAuth.instance.currentUser!.uid)
                PopupMenuButton(
                  color: CacheHelper.getData(key: "isDark")
                      ? Colors.white
                      : Colors.black,
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      height: 7,
                      onTap: () {},
                      child: TextButton(
                        child: const Text('Delete Post'),
                        onPressed: () {
                          var alert = AlertDialog(
                            title: const Center(
                              child: Text(
                                'Alert ! ',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            titlePadding: const EdgeInsets.all(10),
                            content: SizedBox(
                              width: 150,
                              height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Are you sure you want to delete this post ?',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('NO'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          SocialCubit.get(context).deletepost(
                                              SocialCubit.get(context)
                                                  .postId[index]);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('YES'),
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
                        children: const [
                          Icon(
                            IconBroken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(
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
                    const SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: TextFormField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: "wite a comment",
                        ),
                      ),
                    ),
                    const Spacer(),
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
                        child: const Icon(IconBroken.Send)),
                    const SizedBox(
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
                child: const Icon(
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
