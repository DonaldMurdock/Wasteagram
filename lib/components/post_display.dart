import 'package:flutter/material.dart';

import '../screens/details_screen.dart';
import '../models/food_waste_post.dart';

class PostDisplay extends StatelessWidget {
  final FoodWastePost post;

  const PostDisplay({ Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      onTapHint: 'See the details for this post',
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DetailsScreen(post: post),
            )
          );
        },
        child: ListTile(
        leading: Text(post.date),
        trailing: Text(post.quantity.toString())
        )
      )
    );
  }
}