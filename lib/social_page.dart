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
  int check=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('자산 순위'),
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
          var user_data=Map<String, dynamic>();
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
                List<dynamic> asset_order_uid = [];

                int realasset;
                userdoc.forEach((users) {


                  var uidd=users.get('uid');
                  var moneyy=users.get('money');
                  var start1=users.get('startup_1_stocks');
                  var start2=users.get('startup_2_stocks');
                  var start3=users.get('startup_3_stocks');
                  var start4=users.get('startup_4_stocks');
                  var start5=users.get('startup_5_stocks');
                  var start6=users.get('startup_6_stocks');
                  var start7=users.get('startup_7_stocks');
                  var start8=users.get('startup_8_stocks');

                  realasset=price_data['1']*start1+
                      price_data['2']*start2+
                      price_data['3']*start3+
                      price_data['4']*start4+
                      price_data['5']*start5+
                      price_data['6']*start6+
                      price_data['7']*start7+
                      price_data['8']*start8+
                      moneyy;

                  asset[uidd]=realasset;
                  asset_order.add(realasset);
                  asset_order.sort();
                  asset_order=asset_order.reversed.toList();
                  //List<dynamic> asset_list = [];
                  //asset_list.add(realasset);
                  //asset_list.add(users.get('uid'));
                  //asset_order.add(asset_list);
                  user_data[uidd]={
                    'money': moneyy,
                    '1': start1,
                    '2': start2,
                    '3': start3,
                    '4': start4,
                    '5': start5,
                    '6': start6,
                    '7': start7,
                    '8': start8,
                    'asset': realasset,
                    'nick_name': users.get('nick_name'),
                    'full_name': users.get('full_name'),
                    'team': users.get('team')
                  };


                  user_data.forEach((key, value) {
                    asset_order_uid.add(" ");
                    for(int i=0; i<asset_order.length; i++){
                      if(asset_order[i]==value['asset']){
                        user_data[key]['rank']=i+1;

                      }
                    }
                  });


                  user_data.forEach((key, value) {
                    asset_order_uid[value['rank']-1]=key;
                  });

                });


               // asset_order.sort();
                //asset_order=asset_order.reversed;

                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: prices.doc('names').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                      return Text('ERROR');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator());
                      }
                      Map<String, dynamic> name_data = snapshot.data?.data();


                      return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('나의 자산', style: TextStyle(fontSize: 20),),
                                          Text('총 ${asset[widget.user.uid]}원', style: TextStyle(fontSize: 20),)
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('현금', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                          Text('${user_data[widget.user.uid]['money']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('주식 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                          Text('${price_data['1']*user_data[widget.user.uid]['1']+
                                              price_data['2']*user_data[widget.user.uid]['2']+
                                              price_data['3']*user_data[widget.user.uid]['3']+
                                              price_data['4']*user_data[widget.user.uid]['4']+
                                              price_data['5']*user_data[widget.user.uid]['5']+
                                              price_data['6']*user_data[widget.user.uid]['6']+
                                              price_data['7']*user_data[widget.user.uid]['7']+
                                              price_data['8']*user_data[widget.user.uid]['8']
                                          }원',
                                            style: TextStyle(fontSize: 17, color: Colors.black38),)
                                        ],
                                      ),
                                      check%2==0?IconButton(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        color: Colors.blueAccent,
                                        onPressed: () {
                                          setState(() {
                                            check+=1;
                                          });
                                        },
                                      ):
                                      IconButton(
                                        icon: Icon(Icons.keyboard_arrow_up),
                                        color: Colors.blueAccent,
                                        onPressed: () {
                                          setState(() {
                                            check+=1;
                                          });
                                        },
                                      ),
                                      check%2==0?Container():Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${name_data['1']} 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                              Text('${price_data['1']*user_data[widget.user.uid]['1']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${name_data['2']} 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                              Text('${price_data['2']*user_data[widget.user.uid]['2']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${name_data['3']} 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                              Text('${price_data['3']*user_data[widget.user.uid]['3']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${name_data['4']} 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                              Text('${price_data['4']*user_data[widget.user.uid]['4']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${name_data['5']} 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                              Text('${price_data['5']*user_data[widget.user.uid]['5']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${name_data['6']} 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                              Text('${price_data['6']*user_data[widget.user.uid]['6']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${name_data['7']} 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                              Text('${price_data['7']*user_data[widget.user.uid]['7']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${name_data['8']} 평가금액', style: TextStyle(fontSize: 17, color: Colors.black38),),
                                              Text('${price_data['8']*user_data[widget.user.uid]['8']}원', style: TextStyle(fontSize: 17, color: Colors.black38),)
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('전체 자산 순위', style: TextStyle(fontSize: 23, color: Colors.redAccent),),
                                          Text('${user_data[widget.user.uid]['rank']}위', style: TextStyle(fontSize: 23, color: Colors.redAccent),)
                                        ],
                                      ),

                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 6.0, right: 6, bottom: 4),
                                  child: Container(
                                    child: Divider(color: Colors.black, thickness: 1,),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                                Text('전체 자산 순위 Top 5', style: TextStyle(fontSize: 30),),
                                Padding(padding: EdgeInsets.all(10)),

                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('순위', style: TextStyle(fontSize: 15, color: Colors.black45),),
                                      Text('닉네임', style: TextStyle(fontSize: 15, color: Colors.black45),),
                                      Text('자산', style: TextStyle(fontSize: 15, color: Colors.black45),)
                                    ],
                                  ),
                                ),

                                Container(
                                  color:Colors.yellowAccent.withOpacity(0.4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('1위', style: TextStyle(fontSize: 25, color: Colors.black),),
                                        Text('${user_data[asset_order_uid[0]]['nick_name']}', style: TextStyle(fontSize: 25, color: Colors.black),),
                                        Text('${user_data[asset_order_uid[0]]['asset']}원', style: TextStyle(fontSize: 25, color: Colors.black),)
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(5)),
                                Container(
                                  color:Colors.black38.withOpacity(0.2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('2위', style: TextStyle(fontSize: 25, color: Colors.black),),
                                        Text('${user_data[asset_order_uid[1]]['nick_name']}', style: TextStyle(fontSize: 25, color: Colors.black),),
                                        Text('${user_data[asset_order_uid[1]]['asset']}원', style: TextStyle(fontSize: 25, color: Colors.black),)
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(5)),
                                Container(
                                  color:Colors.brown.withOpacity(0.6),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('3위', style: TextStyle(fontSize: 25, color: Colors.black),),
                                        Text('${user_data[asset_order_uid[2]]['nick_name']}', style: TextStyle(fontSize: 25, color: Colors.black),),
                                        Text('${user_data[asset_order_uid[2]]['asset']}원', style: TextStyle(fontSize: 25, color: Colors.black),)
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(5)),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('4위', style: TextStyle(fontSize: 25, color: Colors.black),),
                                      Text('${user_data[asset_order_uid[3]]['nick_name']}', style: TextStyle(fontSize: 25, color: Colors.black),),
                                      Text('${user_data[asset_order_uid[3]]['asset']}원', style: TextStyle(fontSize: 25, color: Colors.black),)
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(5)),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('5위', style: TextStyle(fontSize: 25, color: Colors.black),),
                                      Text('${user_data[asset_order_uid[4]]['nick_name']}', style: TextStyle(fontSize: 25, color: Colors.black),),
                                      Text('${user_data[asset_order_uid[4]]['asset']}원', style: TextStyle(fontSize: 25, color: Colors.black),)
                                    ],
                                  ),
                                ),
                              ],
                            );
                    }
                  ),
                );
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