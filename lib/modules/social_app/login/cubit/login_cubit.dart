// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/social_app/login/cubit/login_states.dart';



class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit()
      : super(
            SocialLoginInitialState()); //3ashan fe constructor me7tag ya5od el initial state
  static SocialLoginCubit get(context) =>
      BlocProvider.of(context); //3ashan a3raf a5od object men el cubit

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrodState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordState());
  }
}
