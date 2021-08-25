import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/root_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
          fontFamily: 'SpoqaHanSansNeo',
          primaryColor: Colors.black,
          accentColor: Colors.black
      ),
      home: RootPage(),
    );
  }
}
