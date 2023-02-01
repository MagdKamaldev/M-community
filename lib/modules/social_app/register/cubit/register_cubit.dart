// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/social_app/register/cubit/register_states.dart';
import '../../../../models/social_app/social_user_model.dart';

class SocialRegisterCubit extends Cubit <SocialAppRegisterStates> {
  SocialRegisterCubit()
      : super(
            SocialRegisterInitialState()); //3ashan fe constructor me7tag ya5od el initial state
  static SocialRegisterCubit get(context) =>
      BlocProvider.of(context); //3ashan a3raf a5od object men el cubit

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createUser(name: name, email: email, phone: phone, uId: value.user!.uid);
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      cover: "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png",
      bio: "Write your bio ...",
      image: "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png",
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordState());
  }
}
