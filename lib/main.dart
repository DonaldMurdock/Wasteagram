import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/list_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      home: ListScreen(title: 'Wasteagram'),
    );
  }
}

