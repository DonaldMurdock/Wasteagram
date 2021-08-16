import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'new_post_screen.dart';
import '../models/food_waste_post.dart';
import '../components/post_display.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListScreenState createState() => _ListScreenState();
}


class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wasteagram')
      ),
      body: SizedBox.expand(child: postList()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: newPostButton(),
    );
  }

  Widget postList(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.length == 0) {
            return Center(child: CircularProgressIndicator());
          }
              
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                FoodWastePost post = FoodWastePost.fromJSON(snapshot.data!.docs[index].data());              
                return PostDisplay(post: post);
              }
            );
        }
        else {      
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget newPostButton(){
    return Semantics(
      button: true,
      enabled: true,
      onTapHint: 'Select an Image',
      child: Padding(
        padding: EdgeInsets.all(10), 
        child: FloatingActionButton(
          child: Icon(Icons.photo_camera),
          onPressed: () async {
            //Get image from gallery and pass the file to the new post screen
            File? image = await getImage();
            Navigator.push( 
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NewPostScreen(image: image),
              ),
            );
          }
        )
      )
    );
  }
  
  Future<File> getImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return File(pickedFile!.path);
  }

}