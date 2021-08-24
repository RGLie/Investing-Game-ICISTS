import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/account_page.dart';
import 'package:investing_game_icists/social_page.dart';
import 'package:investing_game_icists/trade_page.dart';

class TabPage extends StatefulWidget {

  final User user;
  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex=0;
  List _pages;
  @override
  void initState() {
    super.initState();
    _pages=[
      TradePage(widget.user),
      SocialPage(widget.user),
      AccountPage(widget.user)
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _pages[_selectedIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Trade'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Social'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account')
        ],),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}