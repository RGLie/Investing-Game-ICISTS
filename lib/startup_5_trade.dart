import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Startup5Trade extends StatefulWidget {
  final User user;
  bool trade_time;
  Startup5Trade(this.user, this.trade_time);

  @override
  _Startup5TradeState createState() => _Startup5TradeState();
}

class _Startup5TradeState extends State<Startup5Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intel'),
      ),

    );
  }
}
