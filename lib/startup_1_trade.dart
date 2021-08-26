import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Startup1Trade extends StatefulWidget {
  final User user;
  Startup1Trade(this.user);

  @override
  _Startup1TradeState createState() => _Startup1TradeState();
}

class _Startup1TradeState extends State<Startup1Trade> {
  int trade_price=0;
  int num1=0;
  int num2=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _buildBody(),
    );
  }
  Widget _buildBody() {
    CollectionReference prices = FirebaseFirestore.instance.collection('startup_1');
    CollectionReference users = FirebaseFirestore.instance.collection('users');


    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 60,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj'),
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
              Text('삼성전자', style: TextStyle(fontSize: 20),),
              Padding(padding: EdgeInsets.all(8)),
              Expanded(
                child: StreamBuilder<DocumentSnapshot>(
                    stream: prices.doc('price').snapshots(),
                    builder: (context, snap) {
                      Map<String, dynamic> price_data = snap.data?.data() ?? {'price_now' : '0', 'price_past':0};
                      if (snap.hasError) {
                        return Text('ERROR');
                      }
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator());
                      }
                      int past_price = price_data['price_past'];
                      int now_price = price_data['price_now'];
                      int diff = (now_price-past_price).abs();
                      var rise=false;

                      if((now_price - past_price) >= 0){
                        rise=true;
                      }


                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          Text(
                            '현재가',
                            style: TextStyle(color: Colors.black45, fontSize: 11),
                            textAlign: TextAlign.end,
                          ),
                          rise?
                          Text(
                            '${price_data['price_now']} 원',
                            style: TextStyle(fontSize: 19, color: Colors.redAccent),
                          ):
                          Text(
                            '${price_data['price_now']} 원',
                            style: TextStyle(fontSize: 19, color: Colors.indigoAccent),
                          ),
                          rise?
                          Text(
                            '+ ${diff.toString()} 원',
                            style: TextStyle(color: Colors.redAccent),
                            textAlign: TextAlign.end,
                          ):
                          Text(
                            '- ${diff.toString()} 원',
                            style: TextStyle(color: Colors.indigoAccent),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      );
                    }
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 4, top: 8),
                          child: Row(
                            children: [
                              Text('보유주식'),
                              Spacer(),
                              StreamBuilder<DocumentSnapshot>(
                                  stream: users.doc(widget.user.uid).snapshots(),
                                  builder: (context, snap) {
                                    Map<String, dynamic> user_data = snap.data?.data();
                                    if (snap.hasError) {
                                      return Text('ERROR');
                                    }
                                    if (snap.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    return Text('${user_data['startup_1_stocks']}주');
                                  }
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 4),
                          child: Row(
                            children: [
                              Text('보유자산'),
                              Spacer(),
                              StreamBuilder<DocumentSnapshot>(
                                  stream: users.doc(widget.user.uid).snapshots(),
                                  builder: (context, snap) {
                                    Map<String, dynamic> user_data = snap.data?.data();
                                    if (snap.hasError) {
                                      return Text('ERROR');
                                    }
                                    if (snap.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    return Text('${user_data['money']}원');
                                  }
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
                        Container(
                          height:300,
                          child: ListView.builder(
                            itemCount: 12,
                            itemBuilder: (BuildContext context, int index){
                              return StreamBuilder<DocumentSnapshot>(
                                stream: prices.doc('price').snapshots(),
                                builder: (context, snap) {
                                  Map<String, dynamic> price_data = snap.data?.data();
                                  if (snap.hasError) {
                                    return Text('ERROR');
                                  }
                                  if (snap.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        num1=index;
                                        num2=price_data['price_now'];
                                      });


                                      },
                                    child: Container(
                                        height: 25,
                                        child: Center(
                                            child: index==5?
                                            Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.red,
                                                    ),
                                                ),
                                                child: Text('${price_data['price_now']+5000-index*1000}')
                                            )
                                            :Text('${price_data['price_now']+5000-index*1000}')
                                        )
                                    ),
                                  );
                                }
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.0, right: 6, bottom: 8),
                          child: Container(
                            child: Divider(color: Colors.black, thickness: 1,),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 4),
            child: Row(
              children: [
                Text('구매할 가격'),
                Spacer(),
                FutureBuilder(
                  future: set_trade_price(num1, num2),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Text('${snapshot.data.toString()}원');
                  }
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: ElevatedButton(

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),

                    ),
                    onPressed: (){

                    },
                    child: Text('매도'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                    ),
                    onPressed: (){

                    },
                    child: Text('매수'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<int> set_trade_price(int index, int money) async{
    return money+5000-index*1000;
  }


}

