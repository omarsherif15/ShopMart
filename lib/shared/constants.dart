import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shopmart/Layouts/shopLayout.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
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

void navigateTo(BuildContext context,Widget widget) {
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

Widget myDivider() => Container(
  color: Colors.grey[300],
  height: 1,
  width: double.infinity,
);

void signOut (context) {
  CacheHelper.removeData('token').then((value){
    navigateAndKill(context, LoginScreen());
    ShopCubit.get(context).currentIndex = 0;
  });
}

bool isEdit = false;
String editText = 'Edit';
void editPressed({
  required context,
  required email,
  required name,
  required phone,
})
{
  isEdit =! isEdit;
  if(isEdit) {
    editText = 'Save';
    ShopCubit.get(context).emit(EditPressedState());
  } else {
    editText = 'Edit';
    ShopCubit.get(context).updateProfileData(
        email: email,
        name: name,
        phone: phone
    );
  }

}
String getDateTomorrow ()
{
DateTime dateTime =  DateTime.now().add(Duration(days: 1));
String date =  DateFormat.yMMMd().format(dateTime);
return date;
}


Color defaultColor  = Colors.red;

String? token = '';

int cartLength = 0;

