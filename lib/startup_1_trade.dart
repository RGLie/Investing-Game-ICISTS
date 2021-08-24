import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Startup1Trade extends StatefulWidget {
  final User user;
  Startup1Trade(this.user);

  @override
  _Startup1TradeState createState() => _Startup1TradeState();
}

class _Startup1TradeState extends State<Startup1Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Samsung'),
      ),
      body: _buildBody(),
    );
  }
}

Widget _buildBody() {
  return Text('aa');
}
