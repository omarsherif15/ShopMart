import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/searchCubit.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/homeModels/homeModel.dart';
import 'package:shopmart/models/searchModel/searchModel.dart';
import 'package:shopmart/modules/productScreen.dart';
import 'package:shopmart/shared/constants.dart';


class SearchScreen extends StatelessWidget {
  ShopCubit shopCubit;
  SearchScreen(this.shopCubit);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,ShopStates>(
        listener: (context, state){},
        builder:(context, state) {
          SearchCubit cubit = SearchCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 60,
              title: Padding(
                padding: const EdgeInsets.all(7),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 250,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: searchController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'What are you looking for ?',
                          hintStyle: TextStyle(fontSize: 15),
                          prefixIcon: Icon(Icons.search,color: Colors.red,),
                        ),
                        onChanged: (value) {
                          cubit.getSearchData(value);
                        },
                      ),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: ()
                        {
                          pop(context);
                        },
                        child: Text('cancel',style: TextStyle(color: Colors.black),)
                    ),
                  ],
                ),
              ),
            ),
            body: state is SearchLoadingState ?
            Center(child: CircularProgressIndicator()):
            cubit.searchModel != null?
            searchController.text.isEmpty?
            Container(): ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) =>searchItemBuilder(cubit.searchModel?.data.data[index],shopCubit,context) ,
              separatorBuilder:(context,index) => myDivider(),
              itemCount:cubit.searchModel?.data.data.length ?? 10,
            ) :
            Container()
          );
        },

      ),
    );
  }
  Widget searchItemBuilder(SearchProduct? model,ShopCubit shopCubit,context){
    return  InkWell(
     onTap: (){
       shopCubit.getProductData(model!.id);
       navigateTo(context, ProductScreen());
     },
      child: Container(
        height: 120,
        padding: EdgeInsets.all(10),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
