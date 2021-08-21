
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/cartModels/cartModel.dart';
import 'package:shopmart/models/favoritesModels/favoritesModel.dart';
import 'package:shopmart/modules/productScreen.dart';
import 'package:shopmart/shared/constants.dart';

import 'SearchScreen.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {},
      builder:(context,state)
      {
       return Scaffold(
         appBar: AppBar(
           titleSpacing: 0,
           title: Row(
             children: [
               Image(image: AssetImage('assets/images/ShopLogo.png'),width: 50, height: 50,),
               Text('ShopMart'),
             ],
           ),
           actions: [
             IconButton(
                 onPressed: () {
                   navigateTo(context, SearchScreen(ShopCubit.get(context)));
                 },
                 icon: Icon(Icons.search)),


           ],
         ),
         body: Conditional.single(
             context: context,
             conditionBuilder:(context) => state is !FavoritesLoadingState,
             widgetBuilder: (context) => SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                       padding: EdgeInsets.all(10),
                       child: Row(
                         children: [
                           Text('My Wishlist',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                           SizedBox(width: 5,),
                           Text('(${ShopCubit.get(context).favoritesModel!.data.total} items)',style: TextStyle(color: Colors.grey),),
                         ],
                       )),
                   ListView.separated(
                       physics:NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder:(context,index) => favoriteProducts(ShopCubit.get(context).favoritesModel!.data.data[index].product,context),
                       separatorBuilder:(context,index) =>myDivider(),
                       itemCount: ShopCubit.get(context).favoritesModel!.data.data.length
                   ),
                 ],
               ),
             ),
             fallbackBuilder:(context) => Center(child: CircularProgressIndicator())),
       );

      } ,
    );
  }

  Widget favoriteProducts(FavoriteProduct? model,context)
  {
    return InkWell(
      onTap: (){
        ShopCubit.get(context).getProductData(model!.id);
        navigateTo(context, ProductScreen());
      },
      child: Container(
        height: 180,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 100,
              child: Row(
                children:
                [
                  Image(image: NetworkImage('${model!.image}'),width: 100,height: 100,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text('${model.name}',
                          style: TextStyle(fontSize: 15,),maxLines: 3,overflow: TextOverflow.ellipsis,),
                        Spacer(),
                        Text('EGP '+'${model.price}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        if(model.discount != 0)
                          Text('EGP'+'${model.oldPrice}',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Row(
              children:
              [
                Icon(Icons.shopping_cart_outlined,color: Colors.grey,),
                TextButton(
                    onPressed: (){
                      ShopCubit.get(context).changeToFavorite(model.id);
                      ShopCubit.get(context).addToCart(model.id);

                    },
                    child: Text('Add To Cart',style: TextStyle(color: Colors.grey,),)
                ),
                Spacer(),
                Icon(Icons.delete_outline_outlined,color: Colors.grey,),
                TextButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeToFavorite(model.id);
                      ShopCubit.get(context).getFavoriteData();
                    },
                    child: Text('Remove',style: TextStyle(color: Colors.grey,))
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
