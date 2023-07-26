// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialLoginSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialLoginErrorState(e.toString()));
    });
  }

  bool vis = true;
  IconData suffix = Icons.visibility_outlined;
  void visiablePassword() {
    vis = !vis;
    suffix = vis ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginPasswordState());
  }
}
