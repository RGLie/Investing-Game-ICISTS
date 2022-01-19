import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/quiz_detail_page.dart';

class QuizPage extends StatefulWidget {
  final User user;
  QuizPage(this.user);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  MaterialColor graffiti2 = const MaterialColor(
    0xFFFFF990,
    const <int, Color>{
      50: const Color(0xFFFFF990),
      100: const Color(0xFFFFF990),
      200: const Color(0xFFFFF990),
      300: const Color(0xFFFFF990),
      400: const Color(0xFFFFF990),
      500: const Color(0xFFFFF990),
      600: const Color(0xFFFFF990),
      700: const Color(0xFFFFF990),
      800: const Color(0xFFFFF990),
      900: const Color(0xFFFFF990),
    },
  );

  MaterialColor graffiti3 = const MaterialColor(
    0xFF76ECFF,
    const <int, Color>{
      50: const Color(0xFF76ECFF),
      100: const Color(0xFF76ECFF),
      200: const Color(0xFF76ECFF),
      300: const Color(0xFF76ECFF),
      400: const Color(0xFF76ECFF),
      500: const Color(0xFF76ECFF),
      600: const Color(0xFF76ECFF),
      700: const Color(0xFF76ECFF),
      800: const Color(0xFF76ECFF),
      900: const Color(0xFF76ECFF),
    },
  );

  MaterialColor graffiti4 = const MaterialColor(
    0xFF74E88C,
    const <int, Color>{
      50: const Color(0xFF74E88C),
      100: const Color(0xFF74E88C),
      200: const Color(0xFF74E88C),
      300: const Color(0xFF74E88C),
      400: const Color(0xFF74E88C),
      500: const Color(0xFF74E88C),
      600: const Color(0xFF74E88C),
      700: const Color(0xFF74E88C),
      800: const Color(0xFF74E88C),
      900: const Color(0xFF74E88C),
    },
  );

  MaterialColor graffiti1 = const MaterialColor(
    0xFFFF86E6,
    const <int, Color>{
      50: const Color(0xFFFF86E6),
      100: const Color(0xFFFF86E6),
      200: const Color(0xFFFF86E6),
      300: const Color(0xFFFF86E6),
      400: const Color(0xFFFF86E6),
      500: const Color(0xFFFF86E6),
      600: const Color(0xFFFF86E6),
      700: const Color(0xFFFF86E6),
      800: const Color(0xFFFF86E6),
      900: const Color(0xFFFF86E6),
    },
  );

  CollectionReference _tradeStream = FirebaseFirestore.instance.collection('trade_state');
  CollectionReference _userStream = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퀴즈')
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return StreamBuilder<DocumentSnapshot>(
      stream: _userStream.doc(widget.user.uid).snapshots(),
      builder: (context, snap){
        if(snap.hasError){
          return Text('');
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return Text('');
        }
        Map<String, dynamic> user_data = snap.data.data() as Map<String, dynamic>;

        return StreamBuilder<DocumentSnapshot>(
            stream: _tradeStream.doc('quiz_state').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text('');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('');
              }
              Map<String, dynamic> state_data = snapshot.data.data() as Map<String, dynamic>;

              if(!state_data['open']){
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Quiz', style: TextStyle(
                            fontSize: 50
                        ),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text('퀴즈 시간이 아닙니다.')
                        )
                      ]
                  ),
                );
              }

              if(!user_data['quiz_state']){
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Quiz', style: TextStyle(
                            fontSize: 50
                        ),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                            ),
                            onPressed: (){
                              if(state_data['open']){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                //   return QuizDetailPage();
                                // }));
                                CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                                _priceStream.doc(widget.user.uid).update({
                                  'quiz_state': true
                                });
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: const Text('퀴즈 시간이 아닙니다'),
                                  backgroundColor: Colors.redAccent,
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
                            child: Text('퀴즈 풀기', style: TextStyle(color: Colors.black54),),
                          ),
                        )
                      ]
                  ),
                );
              }
              return _buildQuiz(user_data['quiz_num']);
            }
        );
      }


    );
  }

  _buildQuiz(int quiz_num) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('quiz').doc(quiz_num.toString()).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('');
        }
        Map<String, dynamic> quiz_data = snapshot.data.data() as Map<String, dynamic>;


        if(quiz_data['end']){
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Quiz', style: TextStyle(
                      fontSize: 50
                  ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text('모든 퀴즈를 풀었습니다.', style: TextStyle(fontSize: 20),)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:25, right:25),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection('users').doc(widget.user.uid).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text('');
                          }
                          Map<String, dynamic> user_data = snapshot.data.data() as Map<String, dynamic>;

                          if((user_data['quiz_right']/(user_data['quiz_wrong']+user_data['quiz_right']))>=0.7){
                            return Column(
                              children: [
                                Text('정답 ${user_data['quiz_right']}문제, 오답 ${user_data['quiz_wrong']}문제로 퀴즈 풀기에 성공하였습니다.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.indigoAccent),),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                                    ),
                                    onPressed: (){

                                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      //   return QuizDetailPage();
                                      // }));
                                      CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                                      _priceStream.doc(widget.user.uid).update({
                                        'quiz_state': false,
                                        'quiz_right': 0,
                                        'quiz_wrong': 0,
                                        'quiz_num': 0
                                      });


                                    },
                                    child: Text('퀴즈 다시 풀기', style: TextStyle(color: Colors.black54),),
                                  ),
                                )
                              ],
                            );

                          }
                          return Column(
                            children: [
                              Text('정답 ${user_data['quiz_right']}문제, 오답 ${user_data['quiz_wrong']}문제로 퀴즈 풀기에 실패하였습니다.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.redAccent),),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                                  ),
                                  onPressed: (){

                                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      //   return QuizDetailPage();
                                      // }));
                                      CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                                      _priceStream.doc(widget.user.uid).update({
                                        'quiz_state': false,
                                        'quiz_right': 0,
                                        'quiz_wrong': 0,
                                        'quiz_num': 0
                                      });

                                  },
                                  child: Text('퀴즈 다시 풀기', style: TextStyle(color: Colors.black54),),
                                ),
                              )

                            ],
                          );
                        }
                        ),
                  )
                ]
            ),
          );
        }

        return Padding(
          padding:  EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:5,bottom: 5),
                  child: Text(quiz_data['startup']),
                ),
                Padding(
                  padding: EdgeInsets.only(top:5, bottom: 5, left: 40, right: 40),
                  child: Text(quiz_data['question'], textAlign: TextAlign.center ,style: TextStyle(fontSize: 30),),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(graffiti1),
                          ),
                          onPressed: (){
                            if(quiz_data['answer']==1){
                              CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                              _priceStream.doc(widget.user.uid).update({
                                'quiz_num': FieldValue.increment(1),
                                'quiz_right': FieldValue.increment(1),
                              });
                            }
                            else{
                              CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                              _priceStream.doc(widget.user.uid).update({
                                'quiz_num': FieldValue.increment(1),
                                'quiz_wrong': FieldValue.increment(1),
                              });
                            }

                          },
                          child: Container(
                              height: 100,
                              child: Center(child: Text(quiz_data['1'], style: TextStyle(color: Colors.black, fontSize: 20),))
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(graffiti2),
                          ),
                          onPressed: (){
                            if(quiz_data['answer']==2){
                              CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                              _priceStream.doc(widget.user.uid).update({
                                'quiz_num': FieldValue.increment(1),
                                'quiz_right': FieldValue.increment(1),
                              });
                            }
                            else{
                              CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                              _priceStream.doc(widget.user.uid).update({
                                'quiz_num': FieldValue.increment(1),
                                'quiz_wrong': FieldValue.increment(1),
                              });
                            }

                          },
                          child: Container(
                              height: 100,
                              child: Center(child: Text(quiz_data['2'], style: TextStyle(color: Colors.black, fontSize: 20),))
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(3)),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(graffiti3),
                          ),
                          onPressed: (){
                            if(quiz_data['answer']==3){
                              CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                              _priceStream.doc(widget.user.uid).update({
                                'quiz_num': FieldValue.increment(1),
                                'quiz_right': FieldValue.increment(1),
                              });
                            }
                            else{
                              CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                              _priceStream.doc(widget.user.uid).update({
                                'quiz_num': FieldValue.increment(1),
                                'quiz_wrong': FieldValue.increment(1),
                              });
                            }
                          },
                          child: Container(
                              height: 100,
                              child: Center(child: Text(quiz_data['3'], style: TextStyle(color: Colors.black, fontSize: 20),))
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(graffiti4),
                          ),
                          onPressed: (){
                            if(quiz_data['answer']==4){
                              CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                              _priceStream.doc(widget.user.uid).update({
                                'quiz_num': FieldValue.increment(1),
                                'quiz_right': FieldValue.increment(1),
                              });
                            }
                            else{
                              CollectionReference _priceStream = FirebaseFirestore.instance.collection('users');
                              _priceStream.doc(widget.user.uid).update({
                                'quiz_num': FieldValue.increment(1),
                                'quiz_wrong': FieldValue.increment(1),
                              });
                            }
                          },
                          child: Container(
                              height: 100,
                              child: Center(child: Text(quiz_data['4'], style: TextStyle(color: Colors.black, fontSize: 20),))
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      }
    );
  }
}
