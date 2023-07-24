// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants/const.dart';
import 'package:social_app/defaults.dart';
import 'package:social_app/models/shopApp/categories_model.dart';
import 'package:social_app/models/shopApp/change_fav_model.dart';
import 'package:social_app/models/shopApp/fav_model.dart';
import 'package:social_app/models/shopApp/home_mode.dart';
import 'package:social_app/models/shopApp/login_model.dart';
import 'package:social_app/modules/shop_app/categories/categories.dart';
import 'package:social_app/modules/shop_app/cubit/states.dart';
import 'package:social_app/modules/shop_app/favourite/favourite.dart';
import 'package:social_app/modules/shop_app/products/products.dart';
import 'package:social_app/shared/network/end_points.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import '../settings/settings.dart';

class ShopCubit extends Cubit<ShopStates> {
  static ShopCubit get(context) => BlocProvider.of(context);
  ShopCubit() : super(ShopInialState());

  int currentIndexVar = 0;

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeIndex(index) {
    currentIndexVar = index;
    emit(ShopChangeBottomNavState());
  }

  HomeMedel? homeData;

  Map<int, bool> favMap = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeData = HomeMedel.fromJson(value.data);
      homeData?.data.products.forEach(
        (element) {
          favMap.addAll({element['id']: element['in_favorites']});
        },
      );

      print(favMap);

      emit(ShopSuccessHomeDataState());
    }).catchError(
      (e) {
        print(e.toString());
        emit(ShopErrorHomeDataState(e.toString()));
      },
    );
  }

  CategoriesModel? cateModel;
  void getCategoryData() {
    DioHelper.getData(
      url: CATEGRIES,
    ).then((value) {
      cateModel = CategoriesModel.fromJson(value.data);

      print("CAAAAAAT : ${cateModel?.data?.data?[0].id}");
      emit(ShopSuccessCategoriesState());
    }).catchError(
      (e) {
        print(e.toString());
        emit(ShopErrorCategoriesState(e.toString()));
      },
    );
  }

  ChangeFavModel? favModel;
  void changeFav(int productId) {
    favMap[productId] = !favMap[productId]!;
    emit(ShopSuccessChangeFavLightState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favModel = ChangeFavModel.fromJson(value.data);
      print("FAAAAAAAAAAV : ${favModel?.msg}");
      if (!favModel!.status!) {
        favMap[productId] = !favMap[productId]!;
        toastShow(
          txt: "Can't add or remove to Favotites",
          backColor: Colors.red,
        );
      } else {
        getFavData();
      }
      emit(ShopSuccessChangeFavState());
    }).catchError((e) {
      favMap[productId] = !favMap[productId]!;
      toastShow(
        txt: "Can't add or remove to Favotites",
        backColor: Colors.red,
      );
      emit(ShopErrorChangeFavState(e.toString()));
      print(e.toString());
    });
  }

  FavModelFromWebsite? favModelFromWebsite;
  void getFavData() {
    emit(ShopLoadingGetFavLightState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      print("tokennnnnnnn : $token");
      favModelFromWebsite = FavModelFromWebsite.fromJson(value.data);
      emit(ShopSuccessGetFavLightState());
    }).catchError(
      (e) {
        print(e.toString());
        emit(ShopErrorGetFavLightState());
      },
    );
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingGetUsersState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print("userModel Name : ${userModel?.data?.name}");
      emit(ShopSuccessGetUsersState(userModel));
    }).catchError(
      (e) {
        print(e.toString());
        emit(ShopErrorGetUsersState());
      },
    );
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_USER,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print("userModel Name : ${userModel?.data?.name}");
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError(
      (e) {
        print(e.toString());
        emit(ShopErrorUpdateUserState());
      },
    );
  }
}
