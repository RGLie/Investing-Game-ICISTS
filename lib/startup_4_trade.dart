import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Startup4Trade extends StatefulWidget {
  final User user;
  Startup4Trade(this.user);

  @override
  _Startup4TradeState createState() => _Startup4TradeState();
}

class _Startup4TradeState extends State<Startup4Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tesla'),
      ),

    );
  }
}
