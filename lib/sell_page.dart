import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/tab_page.dart';
import 'package:numberpicker/numberpicker.dart';

class SellPage extends StatefulWidget {
  int price;
  int money;
  int num;
  int stock;
  User user;
  SellPage(this.num, this.money, this.stock, this.price, this.user);

  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  int _currentIntValue = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 16),
          Text('몇 주를 매도할까요?',
            style: TextStyle(fontSize: 25),
          ),
          Padding(padding: EdgeInsets.all(3)),
          Text('매도가능수량 ${widget.stock}주',
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Padding(padding: EdgeInsets.all(3)),
          Text('매도 금액 ${widget.price}원',
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          NumberPicker(
            value: _currentIntValue,
            minValue: 0,
            maxValue: widget.stock,
            step: 10,
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
                final newValue = _currentIntValue - 50;
                _currentIntValue = newValue.clamp(0, widget.stock);
                }),
              ),
              Text('매도 수량: $_currentIntValue'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => setState(() {
                final newValue = _currentIntValue + 50;
                _currentIntValue = newValue.clamp(0, widget.stock);
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
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                      ),
                      onPressed: (){


                        CollectionReference trades = FirebaseFirestore.instance.collection('trade_${widget.num}');
                        CollectionReference users = FirebaseFirestore.instance.collection('users');

                        users.doc(widget.user.uid).update({'${widget.num}_isTrade': true});
                        trades.doc('trade_${widget.user.uid}_0').set({
                          'uid': widget.user.uid,
                          'type': 0,
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
