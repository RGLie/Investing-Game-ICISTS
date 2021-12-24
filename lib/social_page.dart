import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatefulWidget {
  final User user;
  SocialPage(this.user);
  final CollectionReference _tradeStream = FirebaseFirestore.instance.collection('users');

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

  _buildBody() {

    return new StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").orderBy('money', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return new Text("There is no expense");
          var userdoc=snapshot.data.docs;

          var asset=Map<String, int>();

          //return ListView(children: List.from(getExpenseItems(snapshot)));


          CollectionReference prices = FirebaseFirestore.instance.collection('price');

          return StreamBuilder<DocumentSnapshot>(
              stream: prices.doc('price').snapshots(),
              builder: (context, snap) {
                if (snap.hasError) {
                  return Text('ERROR');
                }
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator());
                }
                Map<String, dynamic> price_data = snap.data?.data() ?? {'price_now' : '0', 'price_past':0};
                List<dynamic> asset_order = [];
                int realasset;
                userdoc.forEach((users) {
                  realasset=price_data['1']*users.get('startup_1_stocks')+
                      price_data['2']*users.get('startup_2_stocks')+
                      price_data['3']*users.get('startup_3_stocks')+
                      price_data['4']*users.get('startup_4_stocks')+
                      price_data['5']*users.get('startup_5_stocks')+
                      price_data['6']*users.get('startup_6_stocks')+
                      price_data['7']*users.get('startup_7_stocks')+
                      price_data['8']*users.get('startup_8_stocks')+
                      users.get('money');

                  asset[users.get('uid')]=realasset;
                  //List<dynamic> asset_list = [];
                  //asset_list.add(realasset);
                  //asset_list.add(users.get('uid'));
                  //asset_order.add(asset_list);
                });

               // asset_order.sort();
                //asset_order=asset_order.reversed;

                return ListView(children: List.from(_listBuilder(asset)));
              }
          );
          // return ListView(children: getExpenseItems(snapshot));
        });
  }
  List<Widget> _listBuilder(Map<String, int> team_count) {
    List<Widget> l = [];
    team_count.forEach((k, v) => l.add(ListTile(
      title: Text('${v}원'),
    )));
    return l;
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => InkWell(
          child: new ListTile(
          onTap: () {

          },
            title: Text( '${ doc.get('money').toString() } 원'),
            subtitle: new Text(doc.get('nick_name') )
      ),
    )).toList();
  }


}