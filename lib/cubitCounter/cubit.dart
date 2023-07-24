// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubitCounter/states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());
  int counter = 1;

  //To be more easily when use this cubit in many place
  static CounterCubit get(context) => BlocProvider.of(context);

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }
}
