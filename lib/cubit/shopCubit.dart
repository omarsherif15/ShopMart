import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/categoriesModel.dart';
import 'package:shopmart/models/homeModel.dart';
import 'package:shopmart/modules/CategoriesScreen.dart';
import 'package:shopmart/modules/cartScreen.dart';
import 'package:shopmart/modules/favoritesScreen.dart';
import 'package:shopmart/modules/homeScreen.dart';
import 'package:shopmart/modules/myAccountScreen.dart';
import 'package:shopmart/remoteNetwork/dioHelper.dart';
import 'package:shopmart/remoteNetwork/endPoints.dart';
import 'package:shopmart/shared/constants.dart';


class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(
        url: HOME,
        token: token
    ).then((value){
    homeModel = HomeModel.fromJson(value.data);
    printFullText(homeModel!.status.toString());
      emit(HomeSuccessState());
    }).catchError((error){
      emit(HomeErrorState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoryData() {
    emit(CategoriesLoadingState());
    DioHelper.getData(
        url: CATEGORIES,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      printFullText(categoriesModel!.status.toString());
      emit(CategoriesSuccessState());
    }).catchError((error){
      emit(CategoriesErrorState());
      print(error.toString());
    });
  }



  List<BottomNavigationBarItem> navBar =
  [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: 'Categories',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'My Account',
      ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
      ),
    ];


  int currentIndex = 0;
  changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

 List<Widget> screens =
     [
       HomeScreen(),
       CategoriesScreen(),
       MyAccountScreen(),
       FavoritesScreen(),
       CartScreen()
     ];

}