import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubitNews/cubit.dart';
import 'cubitNews/states.dart';
import '../../defaults.dart';

class ScienceSreen extends StatelessWidget {
  const ScienceSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var scienceList = NewsCubit.get(context).science;

        return articleBuilder(scienceList,context);
      },
    );
  }
}
