// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/news_app/business/business_screen.dart';
import 'package:udemy_course/modules/news_app/science/science_screen.dart';
import 'package:udemy_course/modules/news_app/sports/sports_screen.dart';
import 'package:udemy_course/shared/news_cubit/news_states.dart';

import '../networks/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsChangeBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apikey": "361f03ef60814eeba9c3e5e791843cdd",
    }).then((value) {
      business = value.data["articles"];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apikey": "361f03ef60814eeba9c3e5e791843cdd",
      }).then((value) {
        sports = value.data["articles"];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apikey": "361f03ef60814eeba9c3e5e791843cdd",
      }).then((value) {
        science = value.data["articles"];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '361f03ef60814eeba9c3e5e791843cdd',
      },
    ).then((value) {
      print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
