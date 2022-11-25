// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_course/layout/news_app/news_layout.dart';
import 'package:udemy_course/shared/bloc_observer.dart';
import 'package:udemy_course/shared/networks/local/cache_helper.dart';
import 'package:udemy_course/shared/networks/remote/dio_helper.dart';
import 'package:udemy_course/shared/news_cubit/news_cubit.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_cubit.dart';
import 'package:udemy_course/shared/to_do_cubit/todo_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBool(key: "isDark");
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience()),
         BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared: isDark),),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.black),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 30.0,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                primarySwatch: Colors.deepOrange),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor("333739"),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.white),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor("333739"),
                    statusBarBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor("333739"),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 30.0,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor("333739"),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                primarySwatch: Colors.deepOrange),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
