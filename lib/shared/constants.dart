import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/modules/LoginScreen.dart';
import 'package:shopmart/remoteNetwork/cacheHelper.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void showToast(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );}

void navigateTo(context,Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget separator (double wide,double high){
  return SizedBox(width: wide,height: high,);
}

void pop (context) {
  Navigator.pop(context);
}

void navigateAndKill (context,widget) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20),
  child: Container(
    color: Colors.grey[300],
    height: 1,
    width: double.infinity,
  ),
);

void signOut (context) {
  CacheHelper.removeData('token').then((value){
    navigateAndKill(context, LoginScreen());
  });
}

Color defaultColor  = Colors.red;

 String? token = '';
