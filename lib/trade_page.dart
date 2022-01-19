
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:investing_game_icists/startup_1_trade.dart';
import 'package:investing_game_icists/startup_2_trade.dart';
import 'package:investing_game_icists/startup_3_trade.dart';
import 'package:investing_game_icists/startup_4_trade.dart';
import 'package:investing_game_icists/startup_5_trade.dart';
import 'package:investing_game_icists/startup_6_trade.dart';
import 'package:investing_game_icists/startup_7_trade.dart';
import 'package:investing_game_icists/startup_8_trade.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bar_chart.dart';

class TradePage extends StatefulWidget {
  final User user;
  TradePage(this.user);

  @override
  _TradePageState createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  ScrollController _scrollController;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _tradeStream = FirebaseFirestore.instance.collection('trade_state');
  final List<String> startup = <String>['삼성전자', '애플', '알파벳 Inc.', '테슬라', '인텔', '페이스북', '아마존닷컴', '엘지화학'];
  final List<String> startup_image_2 = <String>[
    'https://yt3.ggpht.com/ytc/AKedOLT5YOquq7WTrcTgMFRYdk4-m0ASAd1Io41kSC29bA=s900-c-k-c0x00ffffff-no-rj',
    'https://t1.daumcdn.net/thumb/R720x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/P9h/image/sR7PN1eZ70y5YgfR0zmcvqJNgSg.jpg',
    'https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/5rH/image/aFrEyVpANu07FvoBZQbIB4aF_uc',
    'https://w7.pngwing.com/pngs/629/735/png-transparent-tesla-motors-car-2016-tesla-model-s-electric-vehicle-tesla-logo-angle-vehicle-black-thumbnail.png',
    'https://p4.wallpaperbetter.com/wallpaper/656/370/574/intel-logo-hd-wallpaper-preview.jpg',
    'https://img.extrememanual.net/2016/02/facebook_logo_title.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-DulI841lqJLt-Do_-vz3LoySbpLBac32_QnELGwn4gfjwqybIytvxliprYIiVjb7vE&usqp=CAU',
    'https://e7.pngegg.com/pngimages/80/467/png-clipart-lg-electronics-logo-company-lg-x-power-information-lg-tv-thumbnail.png'
  ];


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
  final List<int> startup_price = <int>[80000, 170000, 3000000, 800000, 55000, 400000, 3500000, 800000];
  int time=1000;
  List _pages=[];
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


  List<double> points = [50, 90, 1003, 500, 150, 120, 200, 80];
  List<String> labels = [ // 가로축에 적을 텍스트(레이블)
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
  ];

  bool _isChecked=true;



  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');


    return Scaffold(
      appBar: AppBar(
        title: Text('거래소'),
        actions: [
          IconButton(
              icon: Icon(Icons.info),
              onPressed: (){
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
                            Padding(padding: EdgeInsets.all(8)),
                            Text('거래 방식 : 단일가 매매', style: TextStyle(fontSize: 20, color: Colors.black)),
                            Padding(padding: EdgeInsets.all(8))
                          ],
                        ),
                        //
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('GRAFFITI Startup Festival 2022 투자게임 세션에서 사용되는 투자 방식은 단일가 매매 방식입니다.'
                                '\n단일가 매매 방식은 실제 주식 시장에서 장외 시간의 거래에 사용됩니다.\n\n'
                            '단일가 매매는 일단 접수된 매수와 매도 주문들을 종합하여 최대한 많은 거래가 이루어질 수 있도록 최종 거래가격을 결정합니다. 매수는 높은 가격부터 우선적으로 체결대상이 되며, 매도는 낮은 가격부터 우선적으로 체결대상이 됩니다.\n'
                            '여기서 최종 거래가격은 주문자가 제시한 가격이 아닌, 매도와 매수 주문의 접점을 찾아 결정됩니다.\n'
                            '같은 가격을 제시한 사람이 많은 경우에는 수량 우선원칙을 따르기 때문에 더 많은 매수나 매도 물량을 제시한 쪽의 물량이 우선적으로 거래됩니다. 최종 체결 가격으로 본인이 매수 신청했을지라도 매도 물량이 부족하다면 거래가 되지 않을 수도 있습니다.'),
                            Padding(padding: EdgeInsets.all(5)),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor.withOpacity(0.7)),
                                  ),
                                  //onPressed: _launchURL(price_data['url']),
                                  onPressed: () async{
                                    _launchURL('https://investdobi.tistory.com/entry/%EB%8B%A8%EC%9D%BC%EA%B0%80%EB%A7%A4%EB%A7%A4%EB%9E%80');
                                  },
                                  child: Text('출처 링크', style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ),
                          ],
                        ),
                          ],
                        ),
                        actions: <Widget>[
                          new TextButton(
                              child: new Text("닫기"),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),

                        ],
                      );
                    });

              }
          )
        ],
      ),

      body: StreamBuilder<DocumentSnapshot>(
        stream: _tradeStream.doc('open').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text(' ');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.only(right: 10.0, left: 10, bottom: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0, right:4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('주식 주문량창 '),
                          Switch(
                              value: _isChecked,
                              activeColor: Colors.greenAccent,
                              onChanged: (value){
                                setState(() {
                                  _isChecked=value;

                                });
                              }
                          ),
                        ],
                      ),
                      Text('거래 방식 설명 \u2191')
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index){
                      CollectionReference prices = FirebaseFirestore.instance.collection('startup_${index+1}');
                      Map<String, dynamic> state_data = snapshot.data.data() as Map<String, dynamic>;
                      return StreamBuilder<DocumentSnapshot>(
                        stream: prices.doc('price').snapshots(),
                        builder: (context, snap) {

                          if (snap.hasError) {
                            return Text('');
                          }
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator());
                          }
                          Map<String, dynamic> price_data = snap.data?.data() ?? {'price_now' : '0', 'price_past':0};
                          int past_price = price_data['price_past'];
                          int now_price = price_data['price_now'];
                          int diff = (now_price-past_price).abs();
                          var rise=false;

                          if((now_price - past_price) >= 0){
                            rise=true;
                          }


                          return InkWell(
                            onTap: () {
                              if(state_data['open']){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return Startup1Trade(widget.user, state_data['open'], index+1, price_data['price_now']);
                                }));

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
                                                backgroundImage: NetworkImage(price_data['image_link']),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 30.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          price_data['name'],
                                                          style: TextStyle(fontSize: 18),
                                                          textAlign: TextAlign.left
                                                      ),
                                                      Text(
                                                          ' ${price_data['code']}',
                                                          style: TextStyle(fontSize: 16, color: Colors.black38),
                                                          textAlign: TextAlign.left
                                                      ),
                                                    ],
                                                  ),
                                                  StreamBuilder<DocumentSnapshot>(
                                                    stream: users.doc(widget.user.uid).snapshots(),
                                                    builder: (context, snapshot) {

                                                      if (snapshot.hasError) {
                                                        return Text(
                                                            '- 주',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black45
                                                            ),
                                                            textAlign: TextAlign.left
                                                        );
                                                      }
                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                        return Text(
                                                            '- 주',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black45
                                                            ),
                                                            textAlign: TextAlign.left
                                                        );
                                                      }
                                                        Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
                                                        return Text(
                                                            '${data['startup_${index+1}_stocks']} 주',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black45
                                                            ),
                                                            textAlign: TextAlign.left
                                                        );


                                                    }
                                                  ),

                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    rise?
                                                    Text(
                                                        '${price_data['price_now']} 원',
                                                      style: TextStyle(fontSize: 17, color: Colors.redAccent),
                                                    ):
                                                    Text(
                                                      '${price_data['price_now']} 원',
                                                      style: TextStyle(fontSize: 17, color: Colors.indigoAccent),
                                                    ),
                                                    rise?
                                                    Text(
                                                      '+ ${diff.toString()} 원',
                                                      style: TextStyle(color: Colors.redAccent),
                                                    ):
                                                    Text(
                                                      '- ${diff.toString()} 원',
                                                      style: TextStyle(color: Colors.indigoAccent),
                                                    ),
                                                  ],
                                                )
                                          ),

                                      ],
                                    ),
                                  )
                                )

                          );
                        }
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),

                if(_isChecked)
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("trade_1").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return new Text("");
                      var tradedoc=snapshot.data.docs;

                      int cnt=0;
                      int tradeVolume_1=0;
                      int tradeVolume_2=0;
                      int tradeVolume_3=0;
                      int tradeVolume_4=0;
                      int tradeVolume_5=0;
                      int tradeVolume_6=0;
                      int tradeVolume_7=0;
                      int tradeVolume_8=0;


                      tradedoc.forEach((trade) {
                        cnt+=trade.get("stock");
                      });
                          tradeVolume_1=cnt;

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("trade_2").snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return new Text("");
                          var tradedoc=snapshot.data.docs;
                          int cnt=0;
                          tradedoc.forEach((trade) {
                            cnt+=trade.get("stock");
                          });
                          tradeVolume_2=cnt;

                          return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("trade_3").snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return new Text("");
                                var tradedoc=snapshot.data.docs;
                                int cnt=0;
                                tradedoc.forEach((trade) {
                                  cnt+=trade.get("stock");
                                });
                                tradeVolume_3=cnt;
                              return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection("trade_4").snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) return new Text("");
                                    var tradedoc=snapshot.data.docs;
                                    int cnt=0;
                                    tradedoc.forEach((trade) {
                                      cnt+=trade.get("stock");
                                    });
                                    tradeVolume_4=cnt;
                                  return StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection("trade_5").snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) return new Text("");
                                        var tradedoc=snapshot.data.docs;
                                        int cnt=0;
                                        tradedoc.forEach((trade) {
                                          cnt+=trade.get("stock");
                                        });
                                        tradeVolume_5=cnt;
                                      return StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance.collection("trade_6").snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) return new Text("");
                                            var tradedoc=snapshot.data.docs;
                                            int cnt=0;
                                            tradedoc.forEach((trade) {
                                              cnt+=trade.get("stock");
                                            });
                                            tradeVolume_6=cnt;
                                          return StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance.collection("trade_7").snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) return new Text("");
                                                var tradedoc=snapshot.data.docs;
                                                int cnt=0;
                                                tradedoc.forEach((trade) {
                                                  cnt+=trade.get("stock");
                                                });
                                                tradeVolume_7=cnt;
                                              return StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore.instance.collection("trade_8").snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) return new Text("");
                                                    var tradedoc=snapshot.data.docs;
                                                    int cnt=0;
                                                    tradedoc.forEach((trade) {
                                                      cnt+=trade.get("stock");
                                                    });
                                                    tradeVolume_8=cnt;
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black12,
                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(5.0),
                                                            child: Center(
                                                              child: Text('주식 주문량', style: TextStyle(fontSize: 20, ),),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20.0, right:20),
                                                            child: Container(
                                                              child: Divider(color: Colors.black, thickness: 1,),
                                                            ),
                                                          ),



                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              height: MediaQuery.of(context).size.height*(0.25),
                                                              child: SfCartesianChart(
                                                                // Enables the legend
                                                                  // Initialize category axis
                                                                  primaryXAxis: CategoryAxis(),


                                                                  series: <ChartSeries>[
                                                                    // Initialize line series
                                                                    ColumnSeries<SalesData, String>(
                                                                        dataSource: [
                                                                          // Bind data source
                                                                          SalesData('GC', tradeVolume_1),
                                                                          SalesData('NJ', tradeVolume_2),
                                                                          SalesData('BC', tradeVolume_3),
                                                                          SalesData('BW', tradeVolume_4),
                                                                          SalesData('AT', tradeVolume_5),
                                                                          SalesData('AS', tradeVolume_6),
                                                                          SalesData('CS', tradeVolume_7),
                                                                          SalesData('PV', tradeVolume_8)
                                                                        ],
                                                                        color: Colors.redAccent,
                                                                        xValueMapper: (SalesData sales, _) => sales.year,
                                                                        yValueMapper: (SalesData sales, _) => sales.sales,
                                                                        dataLabelSettings: DataLabelSettings(isVisible: true)
                                                                    )
                                                                  ]
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:  EdgeInsets.only(right: 10, bottom: 10),
                                                            child: Text('* 주식 주문량은 각 기업의 미체결 매도, 매수 주문의 총 주식 수량입니다.'),
                                                          ),

                                                          // Padding(
                                                          //   padding: const EdgeInsets.all(10.0),
                                                          //   child: CustomPaint(
                                                          //       size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*(0.25)),
                                                          //       foregroundPainter: BarChart(
                                                          //           data: [tradeVolume_1.toDouble(), tradeVolume_2.toDouble(), tradeVolume_3.toDouble(), tradeVolume_4.toDouble(), tradeVolume_5.toDouble(), tradeVolume_6.toDouble(), tradeVolume_7.toDouble(), tradeVolume_8.toDouble()],
                                                          //           labels: ['GC', 'NJ', 'BC', 'BW', 'AT', 'AS', 'CS', 'PV' ],
                                                          //           //labels: ['1','2','3','4','5','6','7','8'],
                                                          //           color: Colors.pinkAccent)),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              );
                                            }
                                          );
                                        }
                                      );
                                    }
                                  );
                                }
                              );
                            }
                          );
                        }
                      );
                    }
                    ),
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Text('웹 진행과 관련된 문의사항 및 오류 등은 카톡 cthero1 또는 인스타 @_2002.jh_으로 바로 연락주세요'),
              )
              ],
            ),
          );
        },
      ) ,
    );
  }
  _scrollListener() async {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // top
    } else if (_scrollController.offset <=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // bottom
    }
  }
  void _signOut() async {
    await _firebaseAuth.signOut();
  }

  _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }


}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}

