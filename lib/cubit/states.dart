import 'package:shopmart/models/loginModel.dart';

abstract class ShopStates {}

//General States
class InitialState extends ShopStates{}
class ChangeModeState extends ShopStates{}
class ChangeBottomNavState extends ShopStates{}
class ChangeSuffixIconState extends ShopStates{}
//End of General states

//Login State
class LoginLoadingState extends ShopStates{}
class LoginSuccessState extends ShopStates{
  final LoginModel userModel;
  LoginSuccessState(this.userModel);
}
class LoginErrorState extends ShopStates{}
//End of Login State


//Home State
class HomeLoadingState extends ShopStates{}
class HomeSuccessState extends ShopStates{}
class HomeErrorState extends ShopStates{}
//End of Home State


//Categories State
class CategoriesLoadingState extends ShopStates{}
class CategoriesSuccessState extends ShopStates{}
class CategoriesErrorState extends ShopStates{}
//End of Categories State


//Search State
class SearchLoadingState extends ShopStates{}
class SearchSuccessState extends ShopStates{}
class SearchErrorState extends ShopStates{}
//End of Search State




