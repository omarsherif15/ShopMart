import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/Layouts/shopLayout.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/signInCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/remoteNetwork/cacheHelper.dart';
import 'package:shopmart/shared/component.dart';
import 'package:shopmart/shared/constants.dart';

class RegisterScreen extends StatelessWidget {

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController confirmPassword = TextEditingController();
var signUpFormKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignInCubit(),
        child:  BlocConsumer<SignInCubit,ShopStates>(
            listener:(context,state){
              if(state is SignUpSuccessState)
                if(state.signUpUserModel.status) {
                  CacheHelper.saveData(
                      key: 'token',
                      value: state.signUpUserModel.data?.token,
                  ).then((value) {
                    token = state.signUpUserModel.data?.token;
                    name.clear();
                    phone.clear();
                    email.clear();
                    password.clear();
                    confirmPassword.clear();
                    navigateAndKill(context, ShopLayout());
                    ShopCubit.get(context).currentIndex = 0;
                    ShopCubit.get(context).getHomeData();
                    ShopCubit.get(context).getProfileData();
                    ShopCubit.get(context).getFavoriteData();
                    ShopCubit.get(context).getCartData();
                    ShopCubit.get(context).getAddresses();

                  });
                } else
                    showToast(state.signUpUserModel.message);
                } ,
            builder:(context,state)
            {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: signUpFormKey,
                  child: Container(
                    padding: EdgeInsets.all(15),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Row(
                          children: [
                            SizedBox(height: 130,),
                            Image(image: AssetImage('assets/images/ShopLogo.png'),width: 40, height: 40,),
                            Text('ShopMart',style: TextStyle(fontSize: 20),),
                            Spacer(),
                            IconButton(
                                onPressed: ()
                                {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        Text('Create a ShopMart account',style: TextStyle(fontSize: 20,),),
                        SizedBox(height: 30,),
                        defaultFormField(
                            context: context,
                            controller: name,
                            label: 'Name',
                            prefix: Icons.person,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                                return 'Name field is required';
                            }
                        ),
                        SizedBox(height: 40,),
                        defaultFormField(
                            context: context,
                            controller: phone,
                            label: 'Phone',
                            keyboardType: TextInputType.phone,
                            prefix: Icons.phone,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                                return 'Phone field is required';
                            }
                        ),
                        SizedBox(height: 40,),

                        defaultFormField(
                            context: context,
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                                return 'Email Address must be filled';
                            }
                        ),
                        SizedBox(height: 40,),
                        defaultFormField(
                            context: context,
                            controller: password,
                            label: 'Password',
                            prefix: Icons.lock,
                            isPassword:SignInCubit.get(context).showPassword ? false : true,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                                return'Password must be filled';
                            },
                            onSubmit: (value) {},
                            suffix: SignInCubit.get(context).suffixIcon,
                            suffixPressed: ()
                            {
                              SignInCubit.get(context).changeSuffixIcon(context);
                            }
                        ),
                        SizedBox(height: 40,),
                        defaultFormField(
                            context: context,
                            controller: confirmPassword,
                            label: 'Confirm Password',
                            prefix: Icons.lock,
                            isPassword:SignInCubit.get(context).showConfirmPassword ? false : true,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                                return 'Name field is required';
                              else if(value != password.text)
                                return 'Password Don\'t Match';
                            },
                            suffix: SignInCubit.get(context).confirmSuffixIcon,
                            suffixPressed: ()
                            {
                              SignInCubit.get(context).changeConfirmSuffixIcon(context);
                            }
                        ),
                        SizedBox(height: 50,),
                        state is SignUpLoadingState ?
                        Center(child: CircularProgressIndicator())
                            :defaultButton(
                            onTap: ()
                            {
                              if(signUpFormKey.currentState!.validate())
                              {
                                SignInCubit.get(context).signUp(
                                    name: name.text,
                                    phone: phone.text,
                                    email: email.text,
                                    password: password.text
                                );
                              }
                            },
                            text: 'Sign Up'
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    ),
    );
  }
  }
