import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/shared/constants.dart';


class SearchScreen extends StatelessWidget {

 final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state){},
        builder:(context, state) {
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
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: 'What are you looking for ?',
                            hintStyle: TextStyle(fontSize: 15),
                            prefixIcon: Icon(Icons.search,color: Colors.red,),
                              ),
                          onChanged: (value) {
                          },
                        ),
                      ),
                      separator(0, 0),
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
              body:// state is SearchLoadingState
              false ?
              Center(child: CircularProgressIndicator()):ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index) => Container(),
                  separatorBuilder:(context,index) => separator(0, 10),
                  itemCount:10
              ),
            );
            },

    );
  }
}
