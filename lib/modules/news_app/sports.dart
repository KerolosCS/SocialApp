import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/news_app/cubitNews/cubit.dart';
import 'package:social_app/modules/news_app/cubitNews/states.dart';

import '../../defaults.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var sportsList = NewsCubit.get(context).sports;

        return articleBuilder(sportsList, context);
      },
    );
  }
}
