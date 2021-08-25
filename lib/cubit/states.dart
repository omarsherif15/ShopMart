import 'package:shopmart/models/addressModels/addAddressModel.dart';
import 'package:shopmart/models/addressModels/update&Delete.dart';
import 'package:shopmart/models/cartModels/addCartModel.dart';
import 'package:shopmart/models/favoritesModels/changeFavoritesModel.dart';
import 'package:shopmart/models/profileModels/logOutModel.dart';
import 'package:shopmart/models/profileModels/userModel.dart';

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

//FCM State
class FCMLoadingState extends ShopStates{}
class FCMSuccessState extends ShopStates{
  final LogOutModel loginUserModel;
  FCMSuccessState(this.loginUserModel);
}
class FCMErrorState extends ShopStates{}
///End of FCM State

///LogOut State
class LogOutLoadingState extends ShopStates{}
class LogOutSuccessState extends ShopStates{
  final LogOutModel logOutUserModel;
  LogOutSuccessState(this.logOutUserModel);
}
class LogOutErrorState extends ShopStates{}
///End of LogOut State

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

///ChangeFavorites State
class ChangeFavoritesLoadingState extends ShopStates{}
class ChangeFavoritesSuccessState extends ShopStates {
  final ChangeToFavoritesModel model;
  ChangeFavoritesSuccessState(this.model);
}
class ChangeFavoritesManuallySuccessState extends ShopStates{}
class ChangeFavoritesErrorState extends ShopStates{}
///End of ChangeFavorites State



///Favorites State
class FavoritesLoadingState extends ShopStates{}
class FavoritesSuccessState extends ShopStates {}
class FavoritesErrorState extends ShopStates{}
///End of Favorites State


///Favorites State
class AddCartLoadingState extends ShopStates{}
class AddCartSuccessState extends ShopStates {
  final AddCartModel addCartModel;

  AddCartSuccessState(this.addCartModel);
}
class AddCartErrorState extends ShopStates{}
///End of Favorites State


///Cart State
class CartLoadingState extends ShopStates{}
class CartSuccessState extends ShopStates {}
class CartErrorState extends ShopStates{}
///End of Cart State

///Cart State
class UpdateCartLoadingState extends ShopStates{}
class UpdateCartSuccessState extends ShopStates {}
class UpdateCartErrorState extends ShopStates{}
class MinusCartItemState extends ShopStates{}
class PlusCartItemState extends ShopStates{}

///End of Cart State

///Add Address State
class AddAddressLoadingState extends ShopStates{}
class AddAddressSuccessState extends ShopStates {
  final AddAddressModel addAddressModel;
  AddAddressSuccessState(this.addAddressModel);
}
class AddAddressErrorState extends ShopStates{}
///End of Add Address State

///Add Update Address State
class UpdateAddressLoadingState extends ShopStates{}
class UpdateAddressSuccessState extends ShopStates {
  final UpdateAddressModel updateAddressModel;
  UpdateAddressSuccessState(this.updateAddressModel);
}class UpdateAddressErrorState extends ShopStates{}
///End of Add Address State

///Add Delete Address State
class DeleteAddressLoadingState extends ShopStates{}
class DeleteAddressSuccessState extends ShopStates {}
class DeleteAddressErrorState extends ShopStates{}
///End of delete Address State

///Addresses State
class AddressesLoadingState extends ShopStates{}
class AddressesSuccessState extends ShopStates {}
class AddressesErrorState extends ShopStates{}
///End of Addresses State

///FAQs State
class FAQsLoadingState extends ShopStates{}
class FAQsSuccessState extends ShopStates {}
class FAQsErrorState extends ShopStates{}
///End of FAQs State

///Profile State
class ProfileLoadingState extends ShopStates{}
class ProfileSuccessState extends ShopStates {}
class ProfileErrorState extends ShopStates{}
///End of Profile State


///Update Profile State
class UpdateProfileLoadingState extends ShopStates{}
class UpdateProfileSuccessState extends ShopStates {
  final UserModel updateUserModel;
  UpdateProfileSuccessState(this.updateUserModel);
}
class UpdateProfileErrorState extends ShopStates{}
///End of Update Profile State

///ChangePassword State
class ChangePassLoadingState extends ShopStates{}
class ChangePassSuccessState extends ShopStates {
  final UserModel passUserModel;
  ChangePassSuccessState(this.passUserModel);
}
class ChangePassErrorState extends ShopStates{}
///End of ChangePassword State

