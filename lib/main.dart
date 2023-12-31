// ignore_for_file: unused_import
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/CubitApp/cubit.dart';
import 'package:social_app/CubitApp/states.dart';
import 'package:social_app/modules/news_app/cubitNews/cubit.dart';
import 'package:social_app/modules/news_app/cubitNews/states.dart';
import 'package:social_app/layout/newsApp/news_layout.dart';
import 'package:social_app/modules/shop_app/onBoarding/on_boarding.dart';
import 'package:social_app/layout/shopApp/shop_layout.dart';
import 'package:social_app/modules/social_app/login_screen/login_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/themes.dart';
import 'constants/const.dart';
import 'package:social_app/modules/shop_app/cubit/cubit.dart';

import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  // ignore: unused_local_variable
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget? startWidget;
  token = CacheHelper.getData(key: 'token');
  // ignore: avoid_print
  print("Token From Main : $token");

  if (onBoarding != null) {
    if (token != null) {
      startWidget = const ShopLayout();
    } else {
      startWidget = null;
    }
  } else {
    startWidget = const OnBoardingScreen();
  }
  runApp(MyApp(
    cachedTheme: isDark,
    startWidget: startWidget,
  ));
}

//https://newsapi.org/
//v2/everything?q=tesla&from=2023-06-13&sortBy=publishedAt&apiKey=5ce4f9c13ddd47ea90ce961c1bd1d149
class MyApp extends StatelessWidget {
  final bool? cachedTheme;
  final Widget? startWidget;
  const MyApp({
    super.key,
    required this.cachedTheme,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AppCubit()..toggleDark(fromShared: cachedTheme)),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getFavData()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            theme: lightMode,
            darkTheme: darkTheme,
            themeMode: !AppCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:
                SocialLoginScreen(), // onBoarding ? LogInScreen(): const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
