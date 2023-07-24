// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/CubitApp/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void toggleDark({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit((AppChangeMode()));
    } else {
      isDark = !isDark;
      CacheHelper.putData('isDark', isDark).then(
        (value) => emit(AppChangeMode()),
      );
    }
  }
}
