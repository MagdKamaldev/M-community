// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:udemy_course/shared/styles/colors.dart';
import 'package:udemy_course/shared/styles/icon_broken.dart';
import '../../../shared/components/constants.dart';

Widget appDrawer(context, cubit, model) => Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(model.image.toString()),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  model.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(height: 1.4),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Container(
              color: defaultColor,
              child: MaterialButton(
                onPressed: () => cubit.changeSocialAppMode(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 13,
                    ),
                    Text(
                      "Change Theme",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(height: 1.4, color: Colors.white),
                    ),
                    const Icon(
                      IconBroken.Filter,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: defaultColor,
              child: MaterialButton(
                onPressed: () => signoutSocial(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 11,
                    ),
                    Text(
                      "Sign Out",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(height: 1.4, color: Colors.white),
                    ),
                    const Icon(
                      IconBroken.Logout,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
