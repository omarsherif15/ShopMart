import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/modules/changePasswordScreen.dart';
import 'package:shopmart/shared/component.dart';
import 'package:shopmart/shared/constants.dart';

import 'SearchScreen.dart';

class ProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {
        if(state is UpdateProfileSuccessState)
          if(state.updateUserModel.status)
            showToast(state.updateUserModel.message);
          else
            showToast(state.updateUserModel.message);
      },
      builder: (context,state)
      {
        ShopCubit cubit =  ShopCubit.get(context);
        var model = cubit.userModel;
        nameController.text = model!.data!.name!;
        phoneController.text =model.data!.phone!;

        return  Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                Image(image: AssetImage('assets/images/ShopLogo.png'),width: 50, height: 50,),
                Text('ShopMart'),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ahlan ${cubit.userModel!.data!.name!.split(' ').elementAt(0)}',
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                        Text('${cubit.userModel!.data!.email}',style: TextStyle(fontSize: 15),),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 280,
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children :
                        [
                          if(state is UpdateProfileLoadingState)
                            Column(
                              children: [
                                LinearProgressIndicator(),
                                SizedBox(height: 20,),
                              ],
                            ),
                          Row(
                            children: [
                              Text('PERSONAL INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              Spacer(),
                              TextButton(
                                  onPressed: ()
                                  {
                                    editPressed(
                                        context: context,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: cubit.userModel!.data!.email
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit,color: Colors.grey,size: 15,),
                                      SizedBox(width: 5,),
                                      Text('$editText',style: TextStyle(color: Colors.grey),),
                                    ],
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),

                          Text('Name',style: TextStyle(fontSize: 15),),
                          defaultFormField(
                              controller: nameController,
                              context: context,
                              prefix: Icons.person,
                              enabled: isEdit ? true:false,
                              validate: (value){}
                          ),
                          SizedBox(height: 40,),
                          Text('Phone',style: TextStyle(fontSize: 15),),
                          defaultFormField(
                              context: context,
                              controller: phoneController,
                              prefix: Icons.phone,
                              enabled: isEdit ? true:false,
                              validate: (value){}
                          ),
                        ]
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    color: Colors.white,
                    width: double.infinity,

                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SECURITY INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        OutlinedButton(
                            onPressed: (){
                              navigateTo(context,ChangePasswordScreen());
                            },
                            child: Text('Change Password')
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:200)
                ],
              ),
            ),
          ),
        );
      },
    );  }
}
