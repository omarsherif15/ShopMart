import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/modules/SearchScreen.dart';
import 'package:shopmart/shared/constants.dart';


class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {} ,
      builder: (context,state) {
        ShopCubit cubit =  ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            titleSpacing: 10,
            title: Row(
              children: [
                Image(image: AssetImage('assets/images/ShopLogo.png'),width: 50, height: 50,),
                Text('ShopMart'),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.navBar,
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeBottomNav(index),

          ),
        );
      },
    );
  }
}
