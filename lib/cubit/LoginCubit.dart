import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/profileModels/logOutModel.dart';
import 'package:shopmart/models/profileModels/userModel.dart';
import 'package:shopmart/remoteNetwork/dioHelper.dart';
import 'package:shopmart/remoteNetwork/endPoints.dart';
import 'package:shopmart/shared/constants.dart';
class LoginCubit extends Cubit<ShopStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? loginModel;
  void signIn({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        token: token,
        data:
        {
          'email': '$email',
          'password': '$password',
        }).then((value) {
          loginModel = UserModel.fromJson(value.data);
          emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }
  // LogOutModel? fcmTokenModel;
  // void setFCM_Token(){
  //   emit(FCMLoadingState());
  //   DioHelper.postData(
  //       url: 'fcm-token',
  //       token: token,
  //       data:
  //       {
  //        "token" : token
  //       }).then((value) {
  //     fcmTokenModel = LogOutModel.fromJson(value.data);
  //     emit(FCMSuccessState(fcmTokenModel!));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(FCMErrorState());
  //   });
  // }


  bool showPassword = false;
  IconData suffixIcon = Icons.visibility;
  void changeSuffixIcon(context){
    showPassword =! showPassword;
    if(showPassword)
      suffixIcon = Icons.visibility_off;
    else
      suffixIcon = Icons.visibility;
    emit(ChangeSuffixIconState());
  }

    
}


