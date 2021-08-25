import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/appCubit.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/modules/LoginScreen.dart';
import 'package:shopmart/modules/addressesScreen.dart';
import 'package:shopmart/modules/favoritesScreen.dart';
import 'package:shopmart/modules/helpScreen.dart';
import 'package:shopmart/modules/profileScreen.dart';
import 'package:shopmart/shared/component.dart';
import 'package:shopmart/shared/constants.dart';

import 'SearchScreen.dart';

class MyAccountScreen extends StatefulWidget {




  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {},
        builder: (context,state)
      {
        ShopCubit cubit =  ShopCubit.get(context);
        bool value = false;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ahlan ${cubit.userModel!.data!.name!.split(' ').elementAt(0)}',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                      Text('${cubit.userModel!.data!.email}',style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                    child: Text('MY ACCOUNT',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                InkWell(
                  onTap: (){
                    navigateTo(context, FavoritesScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                        Icon(Icons.favorite_border_rounded,color: Colors.green,),
                        separator(15, 0),
                        Text('WishList',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: (){
                    navigateTo(context, AddressesScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                        Icon(Icons.location_on_outlined,color: Colors.green,),
                        separator(15, 0),
                        Text('Addresses',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: (){
                    navigateTo(context, ProfileScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                        Icon(Icons.person_outline,color: Colors.green,),
                        separator(15, 0),
                        Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text('SETTINGS',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                InkWell(
                  onTap: (){},
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                        Icon(Icons.dark_mode_outlined,color: Colors.green,),
                        separator(15, 0),
                        Text('Dark Mode',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Spacer(),
                        Switch(
                            value: value ,
                            onChanged: (newValue){
                              setState(() {
                                value = newValue;
                              });

                            },


                        ),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                        Icon(Icons.map_outlined,color: Colors.green,),
                        separator(15, 0),
                        Text('Country',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Spacer(),
                        Text('Egypt'),
                        separator(10,0),
                        Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children:
                      [
                        Icon(Icons.flag_outlined,color: Colors.green,),
                        separator(15, 0),
                        Text('Language',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Spacer(),
                        Text('English'),
                        separator(10,0),
                        Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text('REACH OUT TO US',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                InkWell(
                  onTap: (){
                    ShopCubit.get(context).getFAQsData();
                    navigateTo(context, FAQsScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                        Icon(Icons.info_outline_rounded,color: Colors.green,),
                        separator(15, 0),
                        Text('FAQs',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children:
                      [
                        Icon(Icons.phone_in_talk_outlined,color: Colors.green,),
                        separator(15, 0),
                        Text('Contact Us',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  height: 60,
                  child: InkWell(
                    onTap: (){
                      signOut(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Icon(Icons.power_settings_new),
                        SizedBox(width: 10,),
                        Text('SignOut',style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  ),
                ),






              ],
            ),
          ),
        );
      },
    );
  }
}
