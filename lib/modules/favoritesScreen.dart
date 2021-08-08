
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(Icons.favorite,size:50),
        Text('Favorites Screen'),
      ],
    ),);
  }
}
