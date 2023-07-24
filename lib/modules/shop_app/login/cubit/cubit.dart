import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_app/constants/const.dart';
import 'package:social_app/models/shopApp/login_model.dart';
import 'package:social_app/modules/shop_app/login/cubit/states.dart';
import 'package:social_app/shared/network/end_points.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
    query,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      language: 'en',
      url: LOGIN, //end point from API
      data: {
        'email': email,
        'password': password,
      },
      query: query,
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      // ignore: avoid_print
      print("Token From userLogin : ${loginModel?.data?.token}");
      // ignore: avoid_print
      print("name From userLogin : ${loginModel?.data?.name}");
      emit(ShopLoginSuccessState(loginModel));
    }).catchError(
      (e) {
        // ignore: avoid_print
        print(e.toString());
        emit(
          ShopLoginErrorState(e.toString()),
        );
      },
    );
  }

  bool vis = true;
  IconData suffix = Icons.visibility_outlined;
  void visiablePassword() {
    vis = !vis;
    suffix = vis ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginPasswordState());
  }
}
