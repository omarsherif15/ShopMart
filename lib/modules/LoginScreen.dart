import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/LoginCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/modules/registerScreen.dart';
import 'package:shopmart/Layouts/shopLayout.dart';
import 'package:shopmart/remoteNetwork/cacheHelper.dart';
import 'package:shopmart/shared/component.dart';
import 'package:shopmart/shared/constants.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool hidePassword  = true;
var formKey = GlobalKey<FormState>();
class LoginScreen extends StatelessWidget {

  get obscureText => null;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,ShopStates>(
        listener: (context,state)
        {
          if(state is LoginSuccessState)
          {
            if (state.userModel.status) {
              CacheHelper.saveData(key: 'token', value: state.userModel.data!.token).then((value){
                navigateAndKill(context, ShopLayout());
              });
            }
            else showToast(state.userModel.message);
          }
        },
        builder: (context,state)
        {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child:
                  Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          Image(
                            image: AssetImage('assets/images/ShopLogo.png',),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Email Address',
                              prefix: Icons.email,
                              validate: (value)
                              {
                                if(value!.isEmpty)
                                  return 'Email Address must be filled';
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              label: 'Password',
                              prefix: Icons.lock,
                              isPassword: !cubit.isShown ? true : false,
                              validate: (value)
                              {
                                if(value!.isEmpty)
                                  return'Password must be filled';
                              },
                              onSubmit: (value)
                              {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).loginUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              suffix: cubit.suffixIcon,
                              suffixPressed: ()
                              {
                                cubit.changeSuffixIcon();
                              }
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'Don\'t have an account?'
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: Text('Register Now')
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          state is LoginLoadingState ?
                          Center(child: CircularProgressIndicator())
                              :defaultButton(
                            text: 'LOGIN',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).loginUser(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
