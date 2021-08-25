import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopmart/Layouts/shopLayout.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/homeModels/productModel.dart';
import 'package:shopmart/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'SearchScreen.dart';

class ProductScreen extends StatelessWidget {

  PageController productImages = PageController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          ProductDetailsData ? model = ShopCubit.get(context).productDetailsModel?.data;
          return Scaffold(
            key: scaffoldKey,
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
            body:state is ProductLoadingState? Center(child: CircularProgressIndicator(),) :
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                            child: Text('${model!.name}',style: TextStyle(fontSize: 20),)),
                        Container(
                          height: 400,
                          width: double.infinity,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              PageView.builder(
                                controller: productImages,
                                itemBuilder: (context,index) => Image(
                                    image: NetworkImage('${model.images![index]}'),),
                                itemCount: model.images!.length,
                               ),
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
                                iconSize: 35,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        SmoothPageIndicator(
                            controller: productImages,
                            count: model.images!.length,
                            effect: ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                activeDotColor: Colors.deepOrange,
                                expansionFactor: 4,
                                dotHeight: 7,
                                dotWidth: 10,
                                spacing: 10
                            ),
                        ),
                        SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('EGP '
                                ''+ '${model.price}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            if(model.discount!=0)
                              Row(
                                children: [
                                  Text('EGP'+'${model.oldPrice}',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
                                  SizedBox(width: 5,),
                                  Text('${model.discount}% OFF',style: TextStyle(color: Colors.red),),
                                ],
                              ),
                            SizedBox(height: 15,),
                            myDivider(),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Text('FREE delivery by ',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                                Text('${getDateTomorrow()}'),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text('Order in 19h 16m',style: TextStyle(color: Colors.grey),),
                            SizedBox(height: 15,),
                            myDivider(),
                            SizedBox(height: 15,),
                            Text('Offer Details',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                            SizedBox(height: 10,),
                            Row(children: [
                              Icon(Icons.check_circle_outline,color: Colors.green),
                              SizedBox(width: 5,),
                              Text('Enjoy free returns with this offer'),
                            ],),
                            SizedBox(height: 15,),
                            myDivider(),
                            SizedBox(height: 15,),
                            Row(children: [
                              Icon(Icons.check_circle_outline,color: Colors.green),
                              SizedBox(width: 5,),
                              Text('1 Year warranty'),
                            ],),
                            SizedBox(height: 15,),
                            myDivider(),
                            SizedBox(height: 15,),
                            Row(children: [
                              Icon(Icons.check_circle_outline,color: Colors.green,),
                              SizedBox(width: 5,),
                              Text('Sold by ShopMart'),
                            ],),
                            SizedBox(height: 15,),
                            myDivider(),
                            SizedBox(height: 15,),
                            Text('Overview',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                            SizedBox(height: 15,),
                            Text('${model.description}'),
                            SizedBox(height: 20,),
                          ],
                        ),
                        Container(height: 40,width: double.infinity,)
                      ],),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
                  child: ElevatedButton(

                      onPressed: (){
                        if(ShopCubit.get(context).cart[model.id]) {
                          showToast('Already in Your Cart \nCheck your cart To Edit or Delete ');
                        }
                        else {
                          ShopCubit.get(context).addToCart(model.id);
                          scaffoldKey.currentState!.showBottomSheet(
                                (context) => Container(
                              color: Colors.grey[300],
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.check_circle, color: Colors.green, size: 30,),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${model.name}', maxLines: 2,
                                              overflow: TextOverflow.ellipsis,),
                                            SizedBox(height: 5,),
                                            Text('Added to Cart',
                                              style: TextStyle(color: Colors.grey, fontSize: 13),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('CONTINUE SHOPPING')
                                      ),
                                      SizedBox(width: 10,),
                                      ElevatedButton(
                                        onPressed: () {
                                          navigateTo(context, ShopLayout());
                                          ShopCubit.get(context).currentIndex = 3;
                                        },
                                        child: Text('CHECKOUT'),
                                      ),],),
                                ],),
                            ), elevation: 50,);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined),
                          SizedBox(width: 10,),
                          Text('Add to Cart',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      )
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}
