import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/sell_page.dart';
import 'package:numberpicker/numberpicker.dart';

import 'buy_page.dart';

class Startup1Trade extends StatefulWidget {
  final User user;
  bool trade_time;
  int now_price;
  int num;

  Startup1Trade(this.user, this.trade_time, this.num, this.now_price);

  @override
  _Startup1TradeState createState() => _Startup1TradeState();
}

class _Startup1TradeState extends State<Startup1Trade> {
  int trade_price=0;
  int num1=0;
  int num2=0;
  bool check=false;
  int money;
  int stock;
  int price;
  int _currentPriceValue;
  CollectionReference _tradeStream = FirebaseFirestore.instance.collection('trade_state');

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

  final List<String> startup = <String>['삼성전자', '애플', '알파벳 Inc.', '테슬라', '인텔', '페이스북', '아마존닷컴', '엘지화학'];
  List<String> startup_image=<String>[
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
  ];

  CollectionReference prices;
  CollectionReference users;
  Stream priceStream;
  Stream userStream;

  @override
  void initState(){

    prices = FirebaseFirestore.instance.collection('startup_${widget.num}');
    users = FirebaseFirestore.instance.collection('users');
    priceStream = prices.doc('price').snapshots();
    userStream = users.doc(widget.user.uid).snapshots();
    _currentPriceValue=widget.now_price;



    super.initState();
  }



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



    return StreamBuilder<DocumentSnapshot>(
      stream: priceStream,
      builder: (context, snap) {
        Map<String, dynamic> price_data = snap.data?.data() ?? {'price_now' : '0', 'price_past':0};
        if (snap.hasError) {
          return Text(' ');
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
                      backgroundImage: NetworkImage(price_data['image_link']),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Text(price_data['name'], style: TextStyle(fontSize: 20, color: Colors.black)),
                  Padding(padding: EdgeInsets.all(8)),
                  Expanded(
                    child: Column(
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
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor.withOpacity(0.7)),
                        ),
                        onPressed: () {
                          showDialog(
                          context: context,
                          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              //Dialog Main Title
                              title: Row(
                                children: [
                                  SizedBox(
                                    height: 60,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(price_data['image_link']),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Text(price_data['name'], style: TextStyle(fontSize: 20, color: Colors.black)),
                                  Padding(padding: EdgeInsets.all(8))
                                ],
                              ),
                              //
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(price_data['info1']),
                                  Padding(padding: EdgeInsets.all(5)),
                                  Text(price_data['info2']),
                                ],
                              ),
                              actions: <Widget>[
                                new TextButton(
                                    child: new Text("확인"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }
                                ),

                              ],
                            );
                          });


                        },
                        child: Text('기업정보 더보기'),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: StreamBuilder<DocumentSnapshot>(
                            stream: userStream,
                            builder: (context, snap) {
                              if (snap.hasError) {
                                return Text(' ');
                              }
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              Map<String, dynamic> user_data = snap.data?.data();
                              stock=user_data['startup_${widget.num}_stocks'];
                              money=user_data['money'];
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 4, top: 8),
                                    child: Row(
                                      children: [
                                        Text('보유주식'),
                                        Spacer(),
                                        Text('${user_data['startup_${widget.num}_stocks']}주'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 4),
                                    child: Row(
                                      children: [
                                        Text('보유현금'),
                                        Spacer(),
                                        Text('${user_data['money']}원')
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 6.0, right: 6, bottom: 4),
                                    child: Container(
                                      child: Divider(color: Colors.black, thickness: 1,),
                                    ),
                                  ),

                                  NumberPicker(
                                    value: _currentPriceValue,
                                    minValue: price_data['price_now']-6000,
                                    maxValue: price_data['price_now']+6000,
                                    step: 1000,
                                    haptics: true,
                                    onChanged: (value) => setState(() => _currentPriceValue = value),
                                  ),
                                  SizedBox(height: 32),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () => setState(() {
                                          final newValue = _currentPriceValue - 1000;
                                          _currentPriceValue = newValue.clamp(price_data['price_now']-6000, price_data['price_now']+6000);
                                        }),
                                      ),
                                      Text('주문 가격 : $_currentPriceValue'),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () => setState(() {
                                          final newValue = _currentPriceValue + 1000;
                                          _currentPriceValue = newValue.clamp(price_data['price_now']-6000, price_data['price_now']+6000);
                                        }),
                                      ),
                                    ],
                                  ),
                                  Text('현재 가격 : ${widget.now_price}'),
                                  Padding(
                                    padding: EdgeInsets.only(left: 6.0, right: 6, bottom: 4),

                                  ),
                                  // Container(
                                  //   height:300,
                                  //   child: ListView.builder(
                                  //     itemCount: 12,
                                  //     itemBuilder: (BuildContext context, int index){
                                  //       return StreamBuilder<DocumentSnapshot>(
                                  //           stream: FirebaseFirestore.instance.collection('startup_${widget.num}').doc('price').snapshots(),
                                  //           builder: (context, snap) {
                                  //
                                  //             if (snap.hasError) {
                                  //               return Text('ERROR');
                                  //             }
                                  //             if (snap.connectionState == ConnectionState.waiting) {
                                  //               return Center(
                                  //                   child: CircularProgressIndicator());
                                  //             }
                                  //             Map<String, dynamic> price_data = snap.data.data();
                                  //             return InkWell(
                                  //               onTap: () {
                                  //                 setState(() {
                                  //                   check=true;
                                  //                   num1=index;
                                  //                   num2=price_data['price_now'];
                                  //                 });
                                  //
                                  //
                                  //               },
                                  //               child: Container(
                                  //                   height: 25,
                                  //                   child: Center(
                                  //                       child: index==5?
                                  //                       Container(
                                  //                           decoration: BoxDecoration(
                                  //                             border: Border.all(
                                  //                               width: 1,
                                  //                               color: Colors.red,
                                  //                             ),
                                  //                           ),
                                  //                           child: Text('${price_data['price_now']+5000-index*1000}')
                                  //                       )
                                  //                           :Text('${price_data['price_now']+5000-index*1000}')
                                  //                   )
                                  //               ),
                                  //             );
                                  //           }
                                  //       );
                                  //     },
                                  //   ),
                                  // ),



                                  Padding(
                                    padding: EdgeInsets.only(left: 6.0, right: 6, bottom: 4),
                                    child: Container(
                                      child: Divider(color: Colors.black, thickness: 1,),
                                    ),
                                  ),
                                  Text('미체결 주문'),
                                  Padding(padding: EdgeInsets.all(3)),


                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance.collection('users').doc(widget.user.uid).snapshots(),
                                      builder: (context, snp) {

                                        if (snp.hasError) {
                                          return  Text('미체결 주문이 없습니다',
                                            style: TextStyle(color: Colors.black26, fontSize: 12),
                                          );
                                        }
                                        if (snp.connectionState == ConnectionState.waiting) {
                                          return  Text('미체결 주문이 없습니다',
                                            style: TextStyle(color: Colors.black26, fontSize: 12),
                                          );
                                        }
                                        Map<String, dynamic> user_data = snp.data?.data();
                                        return !user_data['${widget.num}_isTrade']?
                                        Text('미체결 주문이 없습니다',
                                          style: TextStyle(color: Colors.black26, fontSize: 12),
                                        ):Container(
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance.collection("trade_${widget.num}").snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) return new Text("There is no expense");
                                              var tradedoc=snapshot.data.docs;
                                              int amount;
                                              int stock_prices;
                                              int type;


                                              tradedoc.forEach((element) {

                                                if(element.get('uid')==widget.user.uid){
                                                  amount=element.get('stock');
                                                  stock_prices = element.get('price');
                                                  type=element.get('type');
                                                }
                                              });
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  type==1?
                                                  Text( '${ amount.toString() } 주 매수',style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),)
                                                      : Text( '${ amount.toString() } 주 매도',style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.bold),),
                                                  Text('${stock_prices.toString()}원'),
                                                  OutlinedButton(
                                                    onPressed: () async{
                                                      FirebaseFirestore.instance.collection('trade_${widget.num}').doc('trade_${widget.user.uid}_${type.toString()}').delete();
                                                      CollectionReference users = FirebaseFirestore.instance.collection('users');

                                                      //users.doc(widget.user.uid).update({'money': widget.money-total_price});
                                                      int total_price=amount*stock_prices;
                                                      if(type==1){
                                                        users.doc(widget.user.uid).update({'${widget.num}_isTrade': false, 'money':FieldValue.increment(total_price)});
                                                      }
                                                      if(type==0){
                                                        users.doc(widget.user.uid).update({'${widget.num}_isTrade': false, 'startup_${widget.num}_stocks':FieldValue.increment(amount)});
                                                      }


                                                    },
                                                    child: Text('취소'),
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              );
                                            }
                                          ),
                                        );
                                      }
                                  ),

                                  Padding(padding: EdgeInsets.all(8)),
                                ],
                              );
                            }
                          )
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 4),
                child: Row(
                  children: [
                    Text('거래 가격'),
                    Spacer(),
                    Text('${_currentPriceValue}')
                    // FutureBuilder(
                    //     future: set_trade_price(num1, num2),
                    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //       price=snapshot.data;
                    //       return Text('${snapshot.data.toString()}원');
                    //     }
                    // )
                  ],
                ),
              ),

              StreamBuilder<DocumentSnapshot>(
                stream: _tradeStream.doc('open').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Text(' ');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(' ');
                  }
                  Map<String, dynamic> state_data = snapshot.data.data() as Map<String, dynamic>;


                  return StreamBuilder<DocumentSnapshot>(
                    stream:  FirebaseFirestore.instance.collection('users').doc(widget.user.uid).snapshots(),
                    builder: (context, snap) {
                      if(snap.hasError){
                        return Text(' ');
                      }
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Text(' ');
                      }
                      Map<String, dynamic> usertrade_data = snap.data.data() as Map<String, dynamic>;

                      return Row(
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
                                  if(widget.trade_time&&state_data['open']){
                                    if (usertrade_data['${widget.num}_isTrade']==false) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return SellPage(widget.num, money, stock, _currentPriceValue, widget.user);
                                      }));
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: const Text('이미 주문된 거래가 있습니다'),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 3),
                                        action: SnackBarAction(
                                          label: 'Done',
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          },
                                        ),
                                      ));
                                    }
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: const Text('거래 시간이 아닙니다'),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 3),
                                      action: SnackBarAction(
                                        label: 'Done',
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        },
                                      ),
                                    ));
                                  }
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
                                  if(widget.trade_time&&state_data['open']){


                                    if (usertrade_data['${widget.num}_isTrade']==false) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return BuyPage(widget.num, money, stock, _currentPriceValue, widget.user);
                                      }));
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: const Text('이미 주문된 거래가 있습니다'),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 3),
                                        action: SnackBarAction(
                                          label: 'Done',
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          },
                                        ),
                                      ));
                                    }
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: const Text('거래 시간이 아닙니다'),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 3),
                                      action: SnackBarAction(
                                        label: 'Done',
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        },
                                      ),
                                    ));
                                  }

                                },
                                child: Text('매수'),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  );
                }
              )
            ],
          ),
        );
      }
    );
  }

  Future<int> set_trade_price(int index, int money) async{

    return money+5000-index*1000;
  }


}
