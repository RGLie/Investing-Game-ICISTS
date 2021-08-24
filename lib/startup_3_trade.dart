import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Startup3Trade extends StatefulWidget {
  final User user;
  Startup3Trade(this.user);

  @override
  _Startup3TradeState createState() => _Startup3TradeState();
}

class _Startup3TradeState extends State<Startup3Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google'),
      ),

    );
  }
}
