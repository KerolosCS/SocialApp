// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants/const.dart';
import 'package:social_app/cubitCounter/cubit.dart';
import 'package:social_app/cubitCounter/states.dart';
// import 'package:flutter/widgets.dart';

void main(List<String> args) {
  Bloc.observer = MyBlocObserver();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Counter(),
    ),
  );
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          // if (state is CounterInitialState) print("CounterInitialState");
          if (state is CounterPlusState) {
            print("CounterPlusState => Counter is :${state.counter}");
          }
          if (state is CounterMinusState) {
            print("CounterMinusState => Counter is : ${state.counter}");
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).minus();
                    },
                    child: const Text("minus"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${CounterCubit.get(context).counter}",
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: const Text("Plus"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
