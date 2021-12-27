import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final User user;
  QuizPage(this.user);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  CollectionReference _tradeStream = FirebaseFirestore.instance.collection('trade_state');
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
      stream: _tradeStream.doc('quiz_state').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('ERROR');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('ERROR');
        }
        Map<String, dynamic> state_data = snapshot.data.data() as Map<String, dynamic>;
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
    );
  }
}
