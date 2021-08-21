import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/Layouts/shopLayout.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/addressModels/addAddressModel.dart';
import 'package:shopmart/models/addressModels/addressModel.dart';
import 'package:shopmart/models/addressModels/update&Delete.dart';
import 'package:shopmart/models/cartModels/addCartModel.dart';
import 'package:shopmart/models/cartModels/cartModel.dart';
import 'package:shopmart/models/categoriesModels/categoriesDetailsModel.dart';
import 'package:shopmart/models/categoriesModels/categoriesModel.dart';
import 'package:shopmart/models/favoritesModels/changeFavoritesModel.dart';
import 'package:shopmart/models/favoritesModels/favoritesModel.dart';
import 'package:shopmart/models/homeModels/productModel.dart';
import 'package:shopmart/models/profileModels/faqsModels.dart';
import 'package:shopmart/models/homeModels/homeModel.dart';
import 'package:shopmart/models/cartModels/updateCartModel.dart';
import 'package:shopmart/models/profileModels/userModel.dart';
import 'package:shopmart/modules/CategoriesScreen.dart';
import 'package:shopmart/modules/cartScreen.dart';
import 'package:shopmart/modules/homeScreen.dart';
import 'package:shopmart/modules/myAccountScreen.dart';
import 'package:shopmart/remoteNetwork/cacheHelper.dart';
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

  ProductDetailsModel? productDetailsModel;
  void getProductData( productId ) {
    productDetailsModel = null;
    emit(ProductLoadingState());
    DioHelper.getData(
        url: 'products/$productId',
        token: token
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print('Product Detail '+productDetailsModel!.status.toString());
      emit(ProductSuccessState());
    }).catchError((error){
      emit(ProductErrorState());
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
      print('Categories '+categoriesModel!.status.toString());
      emit(CategoriesSuccessState());
    }).catchError((error){
      emit(CategoriesErrorState());
      print(error.toString());
    });
  }

  CategoryDetailModel? categoriesDetailModel;
  void getCategoriesDetailData( int? categoryID ) {
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(
      url: CATEGORIES_DETAIL,
     query: {
       'category_id':'$categoryID',
     }
    ).then((value){
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      print('categories Detail '+categoriesDetailModel!.status.toString());
      emit(CategoryDetailsSuccessState());
    }).catchError((error){
      emit(CategoryDetailsErrorState());
      print(error.toString());
    });
  }

  FavoritesModel ? favoritesModel;
  void getFavoriteData() {
    emit(FavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      print('Favorites '+favoritesModel!.status.toString());
      emit(FavoritesSuccessState());
    }).catchError((error){
      emit(FavoritesErrorState());
      print(error.toString());
    });
  }


  UserModel? userModel;
  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      userModel = UserModel.fromJson(value.data);
      print('Profile '+ favoritesModel!.status.toString());
      print(userModel!.data!.token);
      emit(ProfileSuccessState());
    }).catchError((error){
      emit(ProfileErrorState());
      print(error.toString());
    });
  }

  void updateProfileData({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
        data: {
          'name':name,
          'phone': phone,
          'email': email,
        }
    ).then((value){
      userModel = UserModel.fromJson(value.data);
      print('Update Profile '+ favoritesModel!.status.toString());
      emit(UpdateProfileSuccessState(userModel!));
    }).catchError((error){
      emit(UpdateProfileErrorState());
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
          icon: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Icon(Icons.shopping_cart_outlined),
              if(cartLength != 0)
                Stack(
                  fit: StackFit.passthrough,
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(backgroundColor: Colors.green,radius: 6,),
                  Text('$cartLength',style: TextStyle(fontSize: 10),),
                ],
              ),
            ],
          ),
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
       CartScreen()
     ];

  void getToken () {
    token = CacheHelper.getData('token');
    emit(GetTokenSuccessState());
  }
bool inCart = false;
  Widget topSheet(model,context)
  {
    if(inCart) {
      return MaterialBanner(
          padding: EdgeInsets.zero,
          leading: Icon(Icons.check_circle, color: Colors.green, size: 30,),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model!.name}', maxLines: 2,
                overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5,),
              Text('Added to Cart',
                style: TextStyle(color: Colors.grey, fontSize: 13),)
            ],
          ),
          actions: [
            OutlinedButton(
                onPressed: () {
                  inCart = false;
                  emit(CloseTopSheet());
                },
                child: Text('CONTINUE SHOPPING')
            ),
            ElevatedButton(
              onPressed: () {
                navigateTo(context, ShopLayout());
                ShopCubit.get(context).currentIndex = 3;
              },
              child: Text('CHECKOUT'),
            ),
          ]
      );
    }
    else
      return Container(height: 0,width: 0,);

  }

}