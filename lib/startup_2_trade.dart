import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Startup2Trade extends StatefulWidget {
  final User user;
  Startup2Trade(this.user);

  @override
  _Startup2TradeState createState() => _Startup2TradeState();
}

class _Startup2TradeState extends State<Startup2Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apple'),
      ),

    );
  }
}
