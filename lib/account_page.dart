import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AccountPage extends StatefulWidget {
  final User user;
  AccountPage(this.user);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final List<String> datas = <String>['full_name', 'nick_name', 'team', 'phone_number', 'money', 'startup_1_stocks', 'startup_2_stocks', 'startup_3_stocks','startup_4_stocks','startup_5_stocks','startup_6_stocks','startup_7_stocks','startup_8_stocks'];

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('개인정보'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: (){
                _signOut();
              }
          )
        ],
      ),

      body: _buildBody(),
    );
  }
  void _signOut() async {
    await _firebaseAuth.signOut();
  }

  _buildBody(){
    final List<String> datas_ = <String>['이름', '닉네임', '팀', '전화번호', '돈', '기업1 주식', '기업2 주식', '기업3 주식','기업4 주식','기업5 주식','기업6 주식','기업7 주식','기업8 주식'];
    CollectionReference userstream = FirebaseFirestore.instance.collection('users');

    return StreamBuilder(
      stream: userstream.doc(widget.user.uid).snapshots(),
      builder: (context, snapshot){

        if(snapshot.hasError){
          return Text('ERROR');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        Map<String, dynamic> user_data =snapshot.data.data();


        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                padding: EdgeInsets.only(left: 20, right: 20),
                itemCount: 13,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left:30.0),
                          child: Text(datas_[index]),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right:30.0),
                          child: Text(user_data[datas[index]] is int?user_data[datas[index]].toString():user_data[datas[index]]),
                        ),

                      ],
                    ),
                  );
                }
            )
        );
      },
    );
  }
}
