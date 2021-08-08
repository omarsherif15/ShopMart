import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_cart_outlined,size:50),
        Text('Cart Screen'),
      ],
    ),);  }
}
