

import '../../../../models/shopApp/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel? RegisterModel;

  ShopRegisterSuccessState(this.RegisterModel);

  get loginModel => null;
}

class ShopRegisterPasswordState extends ShopRegisterStates {}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState(this.error);
}
