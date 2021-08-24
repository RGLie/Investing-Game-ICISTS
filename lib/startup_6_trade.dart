import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Startup6Trade extends StatefulWidget {
  final User user;
  Startup6Trade(this.user);

  @override
  _Startup6TradeState createState() => _Startup6TradeState();
}

class _Startup6TradeState extends State<Startup6Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook'),
      ),

    );
  }
}
