import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatefulWidget {
  final User user;
  SocialPage(this.user);


  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('커뮤니티'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
