import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/account_page.dart';
import 'package:investing_game_icists/quiz_page.dart';
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
  MaterialColor kPrimaryColor = const MaterialColor(
    0xFF7568F0,
    const <int, Color>{
      50: const Color(0xFF7568F0),
      100: const Color(0xFF7568F0),
      200: const Color(0xFF7568F0),
      300: const Color(0xFF7568F0),
      400: const Color(0xFF7568F0),
      500: const Color(0xFF7568F0),
      600: const Color(0xFF7568F0),
      700: const Color(0xFF7568F0),
      800: const Color(0xFF7568F0),
      900: const Color(0xFF7568F0),
    },
  );
  @override
  void initState() {
    super.initState();
    _pages=[
      TradePage(widget.user),
      QuizPage(widget.user),
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
        selectedItemColor: kPrimaryColor,

        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: '거래소'),
          BottomNavigationBarItem(icon: Icon(Icons.extension), label: '퀴즈'),
          BottomNavigationBarItem(icon: Icon(Icons.equalizer), label: '랭킹'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '내정보')
        ],),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}