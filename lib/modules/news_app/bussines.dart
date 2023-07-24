import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/news_app/cubitNews/cubit.dart';
import 'package:social_app/modules/news_app/cubitNews/states.dart';
import 'package:social_app/defaults.dart';

class BussinesSreen extends StatelessWidget {
  const BussinesSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var listBusiness = NewsCubit.get(context).business;
        return ConditionalBuilder(
          condition: state is! NewsBusinessLoadingState,
          builder: (context) => RefreshIndicator(
            onRefresh: () {
              NewsCubit.get(context)
                  .changeBottomNavBar(NewsCubit.get(context).currentIndexVar);
              return Future.delayed(
                const Duration(seconds: 0),
              );
            },
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(listBusiness[index], context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: listBusiness.length,
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
