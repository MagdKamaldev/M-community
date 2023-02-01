// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:udemy_course/layout/social_app/cubit/social_states.dart';
import 'package:udemy_course/modules/social_app/profile/profile_screen.dart';
import 'package:udemy_course/shared/components/components.dart';
import '../../../shared/components/constants.dart';

class SocialSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              defaultButton(
                  function: () => navigateTo(context, PorfileScreen()),
                  text: "profile"),
              const SizedBox(
                height: 30,
              ),
              defaultButton(
                  function: () => signoutSocial(context), text: "sign out"),
              const SizedBox(
                height: 30,
              ),
              defaultButton(
                  function: () =>
                      SocialCubit.get(context).changeSocialAppMode(),
                  text: " change theme"),
            ],
          ),
        );
      },
    );
  }
}
