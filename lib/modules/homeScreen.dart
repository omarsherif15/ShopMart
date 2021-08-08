import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/categoriesModel.dart';
import 'package:shopmart/models/homeModel.dart';
import 'package:shopmart/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {

  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        ShopCubit cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.homeModel != null ,
          widgetBuilder:(context) => productBuilder(cubit.homeModel,cubit.categoriesModel),
          fallbackBuilder:(context) => Center(child: CircularProgressIndicator(),),
        );
      }
    );
  }

  Widget productBuilder (HomeModel? model,CategoriesModel? categoriesModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items:model!.data!.banners.map((e) => Image(
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
                itemBuilder:(context,index) => categoriesAvatar(categoriesModel!.data!.data[index]) ,
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
                List.generate(model.data!.products.length,
                        (index) => productItemBuilder(model,index)),
                crossAxisSpacing: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget productItemBuilder (HomeModel? model,index) {
    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.only(start: 8,bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            alignment:AlignmentDirectional.bottomStart,
              children:[
            Image(image: NetworkImage('${model!.data!.products[index].image}'),height: 150,width: 150,),
                if(model.data!.products[index].discount != 0 )
                    Container(
                       color: defaultColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text('Discount',style: TextStyle(fontSize: 14,color: Colors.white),),
                      )
              )
          ]),
          separator(0,10),
          Text('${model.data!.products[index].name}',maxLines: 3, overflow: TextOverflow.ellipsis,),
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
                      Text('${model.data!.products[index].price}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                        ),),
                    ],
                  ),
                  separator(0, 5),
                  if(model.data!.products[index].discount != 0 )
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 10,decoration: TextDecoration.lineThrough,),),
                        Text('${model.data!.products[index].oldPrice}',
                          style: TextStyle(
                            fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                        separator(7, 0),
                        Text('${model.data!.products[index].discount}'+'% OFF',style: TextStyle(color: Colors.red,fontSize: 11),)
                      ],
                    ),
              ]
              ),
              Spacer(),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.favorite_border_rounded,),
                padding: EdgeInsets.all(0),
                iconSize: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget categoriesAvatar(DataModel model) {
    return Column(
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
    );
  }
}
