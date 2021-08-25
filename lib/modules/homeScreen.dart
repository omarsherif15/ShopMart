
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/categoriesModels/categoriesModel.dart';
import 'package:shopmart/models/homeModels/homeModel.dart';
import 'package:shopmart/modules/productScreen.dart';
import 'package:shopmart/shared/constants.dart';

import 'categoryProductsScreen.dart';

class HomeScreen extends StatelessWidget {

  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is HomeSuccessState)
          cartLength = ShopCubit.get(context).cartModel.data!.cartItems.length;
        if(state is ChangeFavoritesSuccessState)
        {
            if (state.model.status == false)
              showToast(state.model.message);
            else
              showToast(state.model.message);
      }
    },
      builder: (context,state)
      {
        ShopCubit cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.homeModel != null ,
          widgetBuilder:(context) => productBuilder(cubit.homeModel,cubit.categoriesModel,context),
          fallbackBuilder:(context) => Center(child: CircularProgressIndicator(),),
        );
      }
    );
  }

  Widget productBuilder (HomeModel? homeModel,CategoriesModel? categoriesModel,context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items:homeModel!.data!.banners.map((e) => Image(
                image: NetworkImage('${e.image}'),fit: BoxFit.cover,width: double.infinity,)).toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(seconds: 1),
                enableInfiniteScroll: true,
                height: 200,
                initialPage: 0,
                reverse: false,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
              carouselController: carouselController,

            ),
            Container(
              color: Colors.white,
              height: 140,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ListView.separated(
                padding: EdgeInsetsDirectional.only(start: 10,top: 10),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder:(context,index) => categoriesAvatar(categoriesModel!.data!.data[index],context) ,
                separatorBuilder:(context,index) => SizedBox(width: 10,) ,
                itemCount:categoriesModel!.data!.data.length,
              ),
            ),
            Container(
              width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Text('Hot Deals',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            separator(0, 1),
            GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children:
                List.generate(
                    homeModel.data!.products.length,
                        (index) => productItemBuilder(homeModel.data!.products[index],context)),
                crossAxisSpacing: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget productItemBuilder (HomeProductModel model,context) {
    return InkWell(
      onTap: (){
        ShopCubit.get(context).getProductData(model.id);
        navigateTo(context, ProductScreen());
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsetsDirectional.only(start: 8,bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Stack(
              alignment:AlignmentDirectional.bottomStart,
                children:[
              Image(image: NetworkImage('${model.image}'),height: 150,width: 150,),
                  if(model.discount != 0 )
                      Container(
                         color: defaultColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('Discount',style: TextStyle(fontSize: 14,color: Colors.white),),
                        )
                )
            ]),
            separator(0,10),
            Text('${model.name}',maxLines: 3, overflow: TextOverflow.ellipsis,),
            Spacer(),
            Row(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                  [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('EGP',style: TextStyle(color: Colors.grey[800],fontSize: 12,),),
                        Text('${model.price}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                          ),),
                      ],
                    ),
                    separator(0, 5),
                    if(model.discount != 0 )
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 10,decoration: TextDecoration.lineThrough,),),
                          Text('${model.oldPrice}',
                            style: TextStyle(
                              fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                          separator(7, 0),
                          Text('${model.discount}'+'% OFF',style: TextStyle(color: Colors.red,fontSize: 11),)
                        ],
                      ),
                ]
                ),
                Spacer(),
                IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeToFavorite(model.id);
                      print(model.id);
                    },
                    icon: Conditional.single(
                      context: context,
                      conditionBuilder:(context) => ShopCubit.get(context).favorites[model.id],
                      widgetBuilder:(context) => ShopCubit.get(context).favoriteIcon,
                      fallbackBuilder: (context) => ShopCubit.get(context).unFavoriteIcon,
                    ),
                  padding: EdgeInsets.all(0),
                  iconSize: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget categoriesAvatar(DataModel model,context) {
    return InkWell(
      onTap: (){
        ShopCubit.get(context).getCategoriesDetailData(model.id);
        navigateTo(context, CategoryProductsScreen(model.name));
      },
      child: Column(
        children:
        [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: defaultColor,
                radius:36 ,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                child: Image(
                  image: NetworkImage('${model.image}'),
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text('${model.name}'),
        ],
      ),
    );
  }
}
