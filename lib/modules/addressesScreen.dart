import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/models/addressModels/addressModel.dart';
import 'package:shopmart/modules/add&UpdateAddress.dart';
import 'package:shopmart/shared/component.dart';
import 'package:shopmart/shared/constants.dart';

import 'SearchScreen.dart';

class AddressesScreen extends StatelessWidget {

  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
      builder: (context,state){
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
            bottomSheet: Container(
              width: double.infinity,
              height: 70,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
              child: MaterialButton(
                onPressed: (){
                  navigateTo(context, UpdateAddressScreen(isEdit: false,));
                },
                color: Colors.deepOrange,
                //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                child: Text('ADD A NEW ADDRESS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder:(context,index) => ShopCubit.get(context).addressModel.data!.data!.length == 0?
                              Container():
                              addressItem(ShopCubit.get(context).addressModel.data!.data![index],context),
                          separatorBuilder:(context,index) => myDivider(),
                          itemCount: ShopCubit.get(context).addressModel.data!.data!.length
                      ),
                      Container(color: Colors.white,height: 70,width: double.infinity,)
                    ],
                  ),
                ),
                // Container(
                //   width: double.infinity,
                //   height: 70,
                //   color: Colors.white,
                //   padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
                //   child: MaterialButton(
                //     onPressed: (){
                //       navigateTo(context, UpdateAddressScreen(isEdit: false,));
                //       },
                //     color: Colors.deepOrange,
                //     //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                //     child: Text('ADD A NEW ADDRESS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                //   ),
                // )
              ],
            ),
          );
      },
    );
    // Container(
    //                   width: double.infinity,
    //                   height: 70,
    //                   color: Colors.white,
    //                   padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
    //                   child: MaterialButton(
    //                     onPressed: (){},
    //                     color: Colors.deepOrange,
    //                     //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    //                     child: Text('Add Address',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 2),),
    //                   ),
    //                 )
  }
  Widget addressItem(AddressData model,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,color: Colors.green,),
              SizedBox(width: 5,),
              Text ('${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Spacer(),
              TextButton(
                  onPressed: (){
                    ShopCubit.get(context).deleteAddress(addressId: model.id);
                  },
                  child: Row(children:
                  [
                    Icon(Icons.delete_outline,size: 17,),
                    Text('Delete')
                  ],)
              ),
              Container(height: 20,width: 1,color: Colors.grey[300],),
              TextButton(
                  onPressed: (){
                    navigateTo(context, UpdateAddressScreen(
                      isEdit: true,
                      addressId: model.id,
                      name: model.name,
                      city: model.city,
                      region: model.region,
                      details: model.details,
                      notes: model.notes,
                    ));
                  },
                  child: Row(children:
                  [
                    Icon(Icons.edit,size: 17,color: Colors.grey,),
                    Text('Edit',style: TextStyle(color: Colors.grey),)
                  ],)
              ),


            ],
          ),
        ),
        myDivider(),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width : 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Region',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Details',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Notes',style: TextStyle(fontSize: 15,color: Colors.grey),),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model.city}',style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text('${model.region}',style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text('${model.details}',style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text('${model.notes}',style: TextStyle(fontSize: 15,)),
                //
                ],)
            ],
          ),
        ),
      ],
    );
  }
}
