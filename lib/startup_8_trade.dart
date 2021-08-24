import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Startup8Trade extends StatefulWidget {
  final User user;
  Startup8Trade(this.user);

  @override
  _Startup8TradeState createState() => _Startup8TradeState();
}

class _Startup8TradeState extends State<Startup8Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LG'),
      ),

    );
  }
}
