import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

import 'dart:io';

class NewPostScreen extends StatefulWidget {
  final File image;

  NewPostScreen({ Key? key, required this.image }) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  TextEditingController numController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Post')),
      body: body()
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - AppBar().preferredSize.height, 
        child: Padding(
          padding: EdgeInsets.all(10), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                photo(),
                SizedBox(height: 10),
                numField(),
              ]),
              postButton()
            ]
          )
        )
      )
    );
  }

  Widget photo() {
    return AspectRatio(
      aspectRatio: 1, 
      child: Image.file(
        widget.image, 
        fit: BoxFit.cover
      )
    );
  }

  Widget numField() {
    return Semantics(
      textField: true,
      enabled: true,
      hint: 'Enter number of wasted items',
      child: Form(
        key: formKey,
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: numController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Number of Wasted Items',  
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required Field!';
            }
          }   
        )
      )
    );
  }

  Widget postButton() {
    return Semantics(
      label: 'Upload data button',
      button: true,
      enabled: true,
      onTapHint: 'Create food waste post',
      child: GestureDetector(
        onTap: () async {
          if(formKey.currentState!.validate()) {
            await createPost();
            Navigator.of(context).pop();
          }
        },
        child: Container(
          width: double.infinity, 
          height: 100, 
          color: Colors.teal,
          child: Icon(
            Icons.file_upload_outlined, 
            size: 50
          )
        )
      )
    );
  }

  Future<void> createPost() async {
    final int numItems = int.parse(numController.text);
    final String url = await getImageURL();
    final LocationData? locationData = await getLocation();

    FirebaseFirestore.instance.collection('posts').add({
      'date' : DateTime.now().toString(),
      'latitude' : locationData!.latitude,
      'longitude' : locationData.longitude,
      'quantity' : numItems,
      'imageURL' : url
    });
  }

  Future<String> getImageURL() async {
    Reference storageReference = FirebaseStorage.instance.ref().child('${DateTime.now().millisecondsSinceEpoch}');

    UploadTask uploadTask = storageReference.putFile(widget.image);
    await uploadTask;

    final url = await storageReference.getDownloadURL();
    return url;
  }

  Future<LocationData?> getLocation() async {
    LocationData? locationData;
    var locationService = Location();

    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return null;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();

    return locationData;
  }
  
}

