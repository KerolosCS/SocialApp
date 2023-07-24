import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/defaults.dart';
import 'package:social_app/modules/shop_app/cubit/states.dart';
import 'package:social_app/modules/shop_app/login/log_in.dart';
import 'package:social_app/modules/shop_app/search/Search.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../modules/shop_app/cubit/cubit.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Moshtrayat"),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  CacheHelper.clearData(key: 'token').then((value) {
                    navigateToWithReplacment(context, LogInScreen());
                  });
                },
                icon: const Icon(Icons.logout_outlined),
              ),

              // IconButton(onPressed: (){}, icon:)
            ],
          ),
          body: cubit.screens[cubit.currentIndexVar],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndexVar,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: "Favourites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
