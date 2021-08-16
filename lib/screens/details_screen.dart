import 'package:flutter/material.dart';

import '../models/food_waste_post.dart';

class DetailsScreen extends StatelessWidget {
  final FoodWastePost post;

  const DetailsScreen({ Key? key, required this.post }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wasteagram')
      ),
      body: body()
    );
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        date(),
        photo(),
        numItems(),
        location()
      ]
    );
  }

  Widget date(){
    return Text(
      post.date, 
      style: TextStyle(fontSize: 30)
    );
  }

  Widget photo(){
    return Semantics(
      label: 'Photo of food waste',
      child: AspectRatio(
        aspectRatio: 1, 
        child: Image.network(
          post.imageURL,
          fit: BoxFit.cover
        )
      )
    );
  }

  Widget numItems(){
    return Text(
      post.quantity == 1 ? '${post.quantity} item' : '${post.quantity} items',
      style: TextStyle(fontSize: 25)
    );
  }

  Widget location(){
    return Text('Location: (${post.latitude}, ${post.longitude})');
  }
}