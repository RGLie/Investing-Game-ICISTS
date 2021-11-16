import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Startup7Trade extends StatefulWidget {
  final User user;
  bool trade_time;
  Startup7Trade(this.user, this.trade_time);

  @override
  _Startup7TradeState createState() => _Startup7TradeState();
}

class _Startup7TradeState extends State<Startup7Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amazon'),
      ),

    );
  }
}
