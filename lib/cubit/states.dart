import 'package:shopmart/models/loginModel.dart';

abstract class ShopStates {}

///General States
class InitialState extends ShopStates{}
class ChangeModeState extends ShopStates{}
class ChangeBottomNavState extends ShopStates{}
class ChangeSuffixIconState extends ShopStates{}
class GetTokenSuccessState extends ShopStates{}
class EditPressedState extends ShopStates{}
class CloseTopSheet extends ShopStates{}
class RefreshPage extends ShopStates{}
///End of General states

///Login State
class LoginLoadingState extends ShopStates{}
class LoginSuccessState extends ShopStates{
  final UserModel loginUserModel;
  LoginSuccessState(this.loginUserModel);
}
class LoginErrorState extends ShopStates{}
///End of Login State

///SignUp State
class SignUpLoadingState extends ShopStates{}
class SignUpSuccessState extends ShopStates{
  final UserModel signUpUserModel;
  SignUpSuccessState(this.signUpUserModel);
}
class SignUpErrorState extends ShopStates{}

///Home State
class HomeLoadingState extends ShopStates{}
class HomeSuccessState extends ShopStates{}
class HomeErrorState extends ShopStates{}
///End of Home State


///Product State
class ProductLoadingState extends ShopStates{}
class ProductSuccessState extends ShopStates{}
class ProductErrorState extends ShopStates{}
///End of Product State

///Categories State
class CategoriesLoadingState extends ShopStates{}
class CategoriesSuccessState extends ShopStates{}
class CategoriesErrorState extends ShopStates{}
///End of Categories State


///CategoriesDetails State
class CategoryDetailsLoadingState extends ShopStates{}
class CategoryDetailsSuccessState extends ShopStates{}
class CategoryDetailsErrorState extends ShopStates{}
///End of CategoriesDetails State


///Search State
class SearchLoadingState extends ShopStates{}
class SearchSuccessState extends ShopStates{}
class SearchErrorState extends ShopStates{}
///End of Search State




