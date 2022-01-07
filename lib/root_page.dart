import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/email_page.dart';
import 'package:investing_game_icists/input_page.dart';
import 'package:investing_game_icists/login_page.dart';
import 'package:investing_game_icists/tab_page.dart';


class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){

          if(!snapshot.hasData){
            return LoginPage();
          }
          // if(!snapshot.data.emailVerified){
          //   return EmailPage(snapshot.data);
          // }
          if(snapshot.data.displayName==null){
            return InputPage(snapshot.data);
          }
          return TabPage(snapshot.data);

        }
    );
  }
}
