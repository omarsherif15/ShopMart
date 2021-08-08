import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.person,size:50),
        Text('My Account'),
      ],
    ),);
  }
}
