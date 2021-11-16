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
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Text('개인정보',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text("이름: ${widget.user.displayName}"),
                  Text("이메일: ${widget.user.email}"),
                  Text("닉네임: ${data['nick_name']}"),
                  Text("전화번호: ${data['phone_number']}"),
                  Text("팀: ${data['team']}"),
                  Text("돈: ${data['money'].toString()}"),
                  Text("기업1 주식: ${data['startup_1_stocks'].toString()}"),
                  Text("기업2 주식: ${data['startup_2_stocks'].toString()}"),
                  Text("기업3 주식: ${data['startup_3_stocks'].toString()}"),
                  Text("기업4 주식: ${data['startup_4_stocks'].toString()}"),
                  Text("기업5 주식: ${data['startup_5_stocks'].toString()}"),
                  Text("기업6 주식: ${data['startup_6_stocks'].toString()}"),
                  Text("기업7 주식: ${data['startup_7_stocks'].toString()}"),
                  Text("기업8 주식: ${data['startup_8_stocks'].toString()}"),

                  Padding(padding: EdgeInsets.all(10)),
                  OutlinedButton(
                    onPressed: () {
                      /*Navigator.push(context, MaterialPageRoute(builder: (context) => ModifyPage(widget.user)));*/
                    },
                    child: Text('개인정보 수정'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
