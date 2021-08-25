import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopmart/Layouts/shopLayout.dart';
import 'package:shopmart/cubit/shopCubit.dart';
import 'package:shopmart/cubit/states.dart';
import 'package:shopmart/modules/SearchScreen.dart';
import 'package:shopmart/modules/addressesScreen.dart';
import 'package:shopmart/shared/component.dart';
import 'package:shopmart/shared/constants.dart';

class UpdateAddressScreen extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  var addressFormKey = GlobalKey<FormState>();

  final bool isEdit;
  final int ?addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;
  UpdateAddressScreen({
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  });


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {
          if (state is UpdateAddressSuccessState){
            if (state.updateAddressModel.status)
              pop(context);
          }
          else if (state is AddAddressSuccessState)
            if(state.addAddressModel.status)
              pop(context);
        },
      builder: (context,state) {
          if(isEdit) {
          nameControl.text = name!;
          cityControl.text = city!;
          regionControl.text = region!;
          detailsControl.text = details!;
          notesControl.text = notes!;
        }
        return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Image(image: AssetImage('assets/images/ShopLogo.png'),width: 50, height: 50,),
                  Text('ShopMart'),
                ],
              ),
              actions:
              [
                TextButton(
                  onPressed: (){
                    pop(context);
                  },
                  child: Text('CANCEL',style: TextStyle(color: Colors.grey),),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: addressFormKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children :
                      [
                        if(state is AddAddressLoadingState || state is UpdateAddressLoadingState)
                          Column(
                            children: [
                              LinearProgressIndicator(),
                              SizedBox(height: 20,),
                            ],
                          ),
                        Text('LOCATION INFORMATION',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),

                        Text('Name',style: TextStyle(fontSize: 15),),
                        TextFormField(
                            controller: nameControl,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText : 'Please enter your Location name',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 17),
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                                return 'This field cant be Empty';
                            }
                        ),
                        SizedBox(height: 40,),
                        Text('City',style: TextStyle(fontSize: 15),),
                        TextFormField(
                            controller: cityControl,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText : 'Please enter your City name',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 17),
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                                return 'This field cant be Empty';
                            }
                        ),
                        SizedBox(height: 40,),
                        Text('Region',style: TextStyle(fontSize: 15),),
                        TextFormField(
                            controller: regionControl,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText : 'Please enter your region',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 17),
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                                return 'This field cant be Empty';
                            }
                        ),
                        SizedBox(height: 40,),
                        Text('Details',style: TextStyle(fontSize: 15),),
                        TextFormField(
                            controller: detailsControl,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText : 'Please enter some details',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 17),
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                                return 'This field cant be Empty';
                            }
                        ),
                        SizedBox(height: 40,),
                        Text('Notes',style: TextStyle(fontSize: 15),),
                        TextFormField(
                             controller: notesControl,
                             textCapitalization: TextCapitalization.words,
                             decoration: InputDecoration(
                              hintText : 'Please add some notes to help find you',
                               hintStyle: TextStyle(color: Colors.grey,fontSize: 17),
                               border: UnderlineInputBorder(),
                             ),
                            validator: (value){
                              if(value!.isEmpty)
                                return 'This field cant be Empty';
                            }
                        ),
                        SizedBox(height:60 ,),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if(addressFormKey.currentState!.validate())
                                {
                                  if(isEdit)
                                    {
                                      ShopCubit.get(context).updateAddress(
                                          addressId: addressId,
                                          name: nameControl.text,
                                          city: cityControl.text,
                                          region: regionControl.text,
                                          details: detailsControl.text,
                                          notes: notesControl.text);
                                    }
                                  else {
                                  ShopCubit.get(context).addAddress(
                                      name: nameControl.text,
                                      city: cityControl.text,
                                      region: regionControl.text,
                                      details: detailsControl.text,
                                      notes: notesControl.text);
                                }
                              }
                              },
                              child: Text('SAVE ADDRESS',style: TextStyle(color: Colors.black,fontSize: 15),)
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),
          );
      },
    );
  }
}
