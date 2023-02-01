// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_null_comparison, avoid_print, unused_local_variable
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:udemy_course/layout/social_app/social_layout.dart';
import 'package:udemy_course/modules/Social_app/login/social_login_screen.dart';
import 'package:udemy_course/shared/bloc_observer.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/networks/local/cache_helper.dart';

import 'package:udemy_course/shared/styles/themes.dart';
import 'layout/social_app/cubit/social_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  //print(token);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget? widget;
  //bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  //token = CacheHelper.getData(key: "token");
  uId = CacheHelper.getData(key: "uId");
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = ShopLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // } else {
  //   widget = OnBoardingScreen();
  // }

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts(),),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: SocialCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startWidget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
