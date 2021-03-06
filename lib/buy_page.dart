import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/tab_page.dart';
import 'package:numberpicker/numberpicker.dart';

class BuyPage extends StatefulWidget {
  int price;
  int money;
  int num;
  int stock;
  User user;
  BuyPage(this.num, this.money, this.stock, this.price, this.user);

  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  int _currentIntValue = 0;

  int possible=10;
  @override
  void initState() {
    super.initState();
    possible=((widget.money/widget.price)).floor();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: AppBar(
        title: Text('Buy',),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
      ),
    );
  }

  _buildBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 16),
          Text('몇 주를 매수할까요?',
            style: TextStyle(fontSize: 25),
          ),
          Padding(padding: EdgeInsets.all(3)),
          Text('매수가능수량 ${possible}주',
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Padding(padding: EdgeInsets.all(3)),
          Text('매수 금액 ${widget.price}원',
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          NumberPicker(
            value: _currentIntValue,
            minValue: 0,
            maxValue: possible,
            step: 1,
            haptics: true,
            onChanged: (value) => setState(() => _currentIntValue = value),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => setState(() {
                  final newValue = _currentIntValue - 10;
                  _currentIntValue = newValue.clamp(10, possible);
                }),
              ),
              Text('매수 수량: $_currentIntValue'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => setState(() {
                  final newValue = _currentIntValue + 10;
                  _currentIntValue = newValue.clamp(10, possible);
                }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ElevatedButton(

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),

                      ),
                      onPressed: (){

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('주문이 접수되었습니다.', style: TextStyle(color: Colors.black45),),
                          backgroundColor: Colors.greenAccent,
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'Done',
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                          ),
                        ));

                        int total_price= widget.price*_currentIntValue;

                        CollectionReference trades = FirebaseFirestore.instance.collection('trade_${widget.num}');
                        CollectionReference users = FirebaseFirestore.instance.collection('users');

                        //users.doc(widget.user.uid).update({'money': widget.money-total_price});
                        users.doc(widget.user.uid).update({'${widget.num}_isTrade': true, 'money':FieldValue.increment(-total_price)});
                        trades.doc('trade_${widget.user.uid}_1').set({
                          'uid': widget.user.uid,
                          'type': 1,
                          'stock': _currentIntValue,
                          'price': widget.price,
                          'have_amount': widget.stock,
                          'have_money':widget.money
                        });

                        Navigator.pop(context);
                      },
                      child: Text('확인'),
                    ),
                  ),
                ),
              ],
            ),
          ),


        ]
    );
  }
}
