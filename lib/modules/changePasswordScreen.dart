import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/modules/profileScreen.dart';
import 'package:shopmart/shared/component.dart';
import 'package:shopmart/shared/constants.dart';

class ChangePasswordScreen extends StatelessWidget {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  var changePasskey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {},
            builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Image(image: AssetImage('assets/images/ShopLogo.png'),width: 50, height: 50,),
                  Text('ShopMart'),
                ],
              ),
              actions:
              [
                TextButton(
                  onPressed: (){
                    pop(context);
                  },
                  child: Text('CANCEL',style: TextStyle(color: Colors.grey),),
                ),
              ],
            ),
            body: Container(
              color: Colors.white,
              width: double.infinity,
              //height: 280,
              padding: EdgeInsets.all(20),
              child: Form(
                key:changePasskey ,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children :
                    [
                      if(state is ChangePassLoadingState)
                        Column(
                          children: [
                            LinearProgressIndicator(),
                            SizedBox(height: 20,),
                          ],
                        ),
                      Text('Current Password',style: TextStyle(fontSize: 15),),
                      TextFormField(
                        controller: currentPass,
                        textCapitalization: TextCapitalization.words,
                        obscureText: !ShopCubit.get(context).showCurrentPassword ? true:false,
                        decoration: InputDecoration(
                          contentPadding:EdgeInsets.all(15) ,
                        hintText : 'Please enter Current Password',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                        border: UnderlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: (){
                              ShopCubit.get(context).changeCurrentPassIcon(context);
                            },
                            icon: Icon (ShopCubit.get(context).currentPasswordIcon)
                          )
                        ),
                        validator: (value){
                          if(value!.isEmpty)
                          return 'This field cant be Empty';
                        }
                      ),
                      SizedBox(height: 40,),
                      Text('New Password',style: TextStyle(fontSize: 15),),
                      TextFormField(
                        controller: newPass,
                        textCapitalization: TextCapitalization.words,
                          obscureText: !ShopCubit.get(context).showNewPassword ? true:false,
                          decoration: InputDecoration(
                              contentPadding:EdgeInsets.all(15) ,
                              hintText : 'Please enter New Password',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                        border: UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    ShopCubit.get(context).changeNewPassIcon(context);
                                  },
                                  icon: Icon (ShopCubit.get(context).newPasswordIcon)
                              )
                        ),
                        validator: (value){
                          if(value!.isEmpty)
                          return 'This field cant be Empty';
                        }),
                      Spacer(),
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){
                              if(changePasskey.currentState!.validate())
                                {
                                  ShopCubit.get(context).changePassword(
                                    context: context,
                                      currentPass: currentPass.text,
                                      newPass: newPass.text,
                                  );
                                }
                            },
                            child: Text('Change Password')
                        ),
                      ),

                  ]),
              )
                ),
          );
        }
    );
  }
}
