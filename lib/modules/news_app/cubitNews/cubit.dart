// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/news_app/cubitNews/states.dart';
import 'package:social_app/modules/news_app/science.dart';
// import 'package:social_app/modules/settings.dart';
import 'package:social_app/modules/news_app/sports.dart';

import '../bussines.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndexVar = 0;
  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_sharp),
      label: "Business ",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: "Science",
    // ),
  ];

  void changeBottomNavBar(index) {
    currentIndexVar = index;

    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsBottomNav());
  }

  List<Widget> screens = const [
    BussinesSreen(),
    SportsScreen(),
    ScienceSreen(),
    // SettingsScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country": "us",
        "category": "business",
        "apiKey": "5ce4f9c13ddd47ea90ce961c1bd1d149",
      },
    ).then((value) {
      business = value.data['articles'];
      print("Size of VALUE : ${value.data.toString().length}");
      print('business[0] : ${business[0]['title']}');
      emit(NewsGetBusinessSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetBusinessErroState(e.toString()));
    });
  }

  void getSports() {
    emit(NewsSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "us",
          "category": "sports",
          "apiKey": "5ce4f9c13ddd47ea90ce961c1bd1d149",
        },
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
        print(value.data.toString().length);
        // print(value.data['totalResults']);
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetSportsErroState(e.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "science",
          "apiKey": "5ce4f9c13ddd47ea90ce961c1bd1d149",
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
        print(value.data.toString().length);
        // print(value.data['totalResults']);
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetScienceErroState(e.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String val) {
    //https://newsapi.org/
    //v2/everything?
    //q=tesla&from=2023-07-12&sortBy=publishedAt&apiKey=5ce4f9c13ddd47ea90ce961c1bd1d149
    search = [];
    DioHelper.getData(
      url: "v2/everything",
      query: {
        'q': val,
        "apiKey": "5ce4f9c13ddd47ea90ce961c1bd1d149",
      },
    ).then((value) {
      emit(NewsSearchLoadingState());
      search = value.data['articles'];
      emit(NewsSearchSuccessState());
      print(value.data.toString().length);
      // print(value.data['totalResults']);
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetScienceErroState(e.toString()));
    });
  }

  bool isDark = false;
  void toggleDark({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsDarkStates());
    } else {
      isDark = !isDark;
      CacheHelper.putData('isDark', isDark).then(
        (value) => emit(NewsDarkStates()),
      );
    }
  }

  void mshFahem() {
    emit(MshFahmak3ayezEh());
  }
}
