import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/profileModels/faqsModels.dart';
import 'package:shopmart/shared/constants.dart';

import 'SearchScreen.dart';

class FAQsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
      builder: (context,state){
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  Image(image: AssetImage('assets/images/ShopLogo.png'),width: 50, height: 50,),
                  Text('ShopMart'),
                ],
              ),
            ),
            body:state is FAQsLoadingState? Center(child: CircularProgressIndicator(),):
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[300],
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      child: Text('FAQs',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder:(context,index) => faqsItemBuilder(cubit.faqsModel.data!.data![index]) ,
                      separatorBuilder:(context,index) => myDivider(),
                      itemCount: cubit.faqsModel.data!.data!.length
                  ),
                ],
              ),
            ),
          );
      }
    );
  }
  Widget faqsItemBuilder (FAQsData model)
  {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text('${model.question}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 15,),
          Text('${model.answer}',style: TextStyle(fontSize: 15),)
        ],
      ),
    );
  }
}
