// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:udemy_course/layout/social_app/cubit/social_states.dart';
import 'package:udemy_course/models/social_app/messege_model.dart';
import 'package:udemy_course/models/social_app/social_user_model.dart';
import 'package:udemy_course/shared/styles/colors.dart';
import 'package:udemy_course/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  
  SocialUserModel? userModel;
  ChatDetailsScreen({this.userModel});

  var messegeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMesseges(recieverId: userModel!.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage:
                          NetworkImage(userModel!.image.toString()),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(userModel!.name!)
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messeges.isNotEmpty ||
                    state is SocialGetMessegeSuccessState,
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var messege =
                                  SocialCubit.get(context).messeges[index];
                              if (SocialCubit.get(context).userModel!.uId ==
                                  messege.senderId) {
                                return buildMyMessege(messege);
                              } else {
                                return buildMessege(messege);
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            itemCount:
                                SocialCubit.get(context).messeges.length),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300]!, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: TextFormField(
                              controller: messegeController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type Your messege !"),
                            )),
                            Container(
                                height: 50,
                                color: defaultColor,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessege(
                                        recieverId: userModel!.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messegeController.text);
                                    messegeController.text = "";
                                  },
                                  child: const Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessege(MessegeModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              )),
          child: Text(model.text.toString()),
        ),
      );

  Widget buildMyMessege(MessegeModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(.7),
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              )),
          child: Text(
            model.text.toString(),
          ),
        ),
      );
}
