// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/SocialApp/user_model.dart';
import 'package:social_app/modules/Social_app/Register/cubit/states.dart';
import '../../../../models/shopApp/login_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);

      userCreateAccount(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(SocialRegisterSuccessState());
    }).catchError((e) {
      print("ERRROOORORORR: ${e.toString()}");
      emit(SocialRegisterErrorState(e.toString()));
    });
  }

  void userCreateAccount({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel socialUserModel = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          socialUserModel.toMap(),
        )
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((e) {
      print('Iam an error from Social CreateUser : $e.toString()');
      emit(SocialCreateUserErrorState(e.toString()));
    });
  }

  bool vis = true;
  IconData suffix = Icons.visibility_outlined;
  void visiablePassword() {
    vis = !vis;
    suffix = vis ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordState());
  }
}
