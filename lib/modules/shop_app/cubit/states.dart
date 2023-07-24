import 'package:social_app/models/shopApp/login_model.dart';

abstract class ShopStates {}

class ShopInialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavState extends ShopStates {}

class ShopErrorChangeFavState extends ShopStates {
  final String error;

  ShopErrorChangeFavState(this.error);
}

class ShopSuccessChangeFavLightState extends ShopStates {}

class ShopSuccessGetFavLightState extends ShopStates {}

class ShopLoadingGetFavLightState extends ShopStates {}

class ShopErrorGetFavLightState extends ShopStates {}

class ShopLoadingGetUsersState extends ShopStates {}

class ShopSuccessGetUsersState extends ShopStates {
  final ShopLoginModel? shopLoginModel;
  ShopSuccessGetUsersState(this.shopLoginModel);
}

class ShopErrorGetUsersState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel? shopLoginModel;
  ShopSuccessUpdateUserState(this.shopLoginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}
