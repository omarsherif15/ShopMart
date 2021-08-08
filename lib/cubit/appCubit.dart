import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/remoteNetwork/cacheHelper.dart';

class AppCubit extends Cubit<ShopStates>{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  IconData? icon = Icons.brightness_4_outlined;
  ThemeMode appMode = ThemeMode.light;

  void changeMode({fromCache}) {
    if(fromCache == null)
      isDark =!isDark;
    else
      isDark = fromCache;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      if(isDark)
      {
        icon = Icons.brightness_7;
        appMode = ThemeMode.dark;
      }
      else
      {
        icon = Icons.brightness_4_outlined;
        appMode = ThemeMode.light;
      }

      emit(ChangeModeState());
    });

  }
}