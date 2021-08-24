import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/startup_1_trade.dart';
import 'package:investing_game_icists/startup_2_trade.dart';
import 'package:investing_game_icists/startup_3_trade.dart';
import 'package:investing_game_icists/startup_4_trade.dart';
import 'package:investing_game_icists/startup_5_trade.dart';
import 'package:investing_game_icists/startup_6_trade.dart';
import 'package:investing_game_icists/startup_7_trade.dart';
import 'package:investing_game_icists/startup_8_trade.dart';

class TradePage extends StatefulWidget {
  final User user;
  TradePage(this.user);

  @override
  _TradePageState createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _tradeStream = FirebaseFirestore.instance.collection('trade_state');
  final List<String> startup = <String>['Samsung', 'Apple', 'Google', 'Tesla', 'Intel', 'Facebook', 'Amazon', 'LG'];
  final List<String> startup_image = <String>[
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://t1.daumcdn.net/thumb/R720x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/P9h/image/sR7PN1eZ70y5YgfR0zmcvqJNgSg.jpg',
    'https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/5rH/image/aFrEyVpANu07FvoBZQbIB4aF_uc',
    'https://w7.pngwing.com/pngs/629/735/png-transparent-tesla-motors-car-2016-tesla-model-s-electric-vehicle-tesla-logo-angle-vehicle-black-thumbnail.png',
    'https://p4.wallpaperbetter.com/wallpaper/656/370/574/intel-logo-hd-wallpaper-preview.jpg',
    'https://img.extrememanual.net/2016/02/facebook_logo_title.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-DulI841lqJLt-Do_-vz3LoySbpLBac32_QnELGwn4gfjwqybIytvxliprYIiVjb7vE&usqp=CAU',
    'https://e7.pngegg.com/pngimages/80/467/png-clipart-lg-electronics-logo-company-lg-x-power-information-lg-tv-thumbnail.png'
  ];
  final List<int> startup_price = <int>[80000, 170000, 3000000, 800000, 55000, 400000, 3500000, 800000];
  int time=1000;
  List _pages=[];


  @override
  void initState() {
    super.initState();
    _pages=[
      Startup1Trade(widget.user),
      Startup1Trade(widget.user),
      Startup1Trade(widget.user),
      Startup1Trade(widget.user),
      Startup1Trade(widget.user),
      Startup1Trade(widget.user),
      Startup1Trade(widget.user),
      Startup1Trade(widget.user),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trading'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _tradeStream.doc('open').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('ERROR');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 600,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index){
                      Map<String, dynamic> state_data = snapshot.data.data() as Map<String, dynamic>;
                      return InkWell(
                        onTap: () {
                          if(state_data['open']){
                            if(index==0){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Startup1Trade(widget.user);
                              }));
                            }
                            if(index==1){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Startup2Trade(widget.user);
                              }));
                            }
                            if(index==2){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Startup3Trade(widget.user);
                              }));
                            }
                            if(index==3){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Startup4Trade(widget.user);
                              }));
                            }
                            if(index==4){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Startup5Trade(widget.user);
                              }));
                            }
                            if(index==5){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Startup6Trade(widget.user);
                              }));
                            }
                            if(index==6){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Startup7Trade(widget.user);
                              }));
                            }
                            if(index==7){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Startup8Trade(widget.user);
                              }));
                            }

                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('주식 거래 시간이 아닙니다.'),
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
                        child: Container(
                          height: 60,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(startup_image[index]),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 30.0),
                                      child: Center(
                                          child: Text(
                                              '${startup[index]}',
                                              style: TextStyle(fontSize: 18),
                                              textAlign: TextAlign.left
                                          )
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(child: Text('${startup_price[index].toString()} 원')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),
              ],
            ),
          );
        },
      ) ,
    );
  }

  void _signOut() async {
    await _firebaseAuth.signOut();
  }

}

