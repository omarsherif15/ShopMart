import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/loginModel.dart';
import 'package:shopmart/remoteNetwork/dioHelper.dart';
import 'package:shopmart/remoteNetwork/endPoints.dart';
class LoginCubit extends Cubit<ShopStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? userModel;
  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email': '$email',
          'password': '$password',
        }).then((value) {
          userModel = LoginModel.fromJson(value.data);
          emit(LoginSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }
 
    
    
    bool isShown = false;
    IconData suffixIcon = Icons.visibility;
    void changeSuffixIcon() {
      isShown =! isShown;
      if(isShown)
        suffixIcon = Icons.visibility_off;
      else
        suffixIcon = Icons.visibility;
      emit(ChangeSuffixIconState());
    }
}


