import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/root_page.dart';

class EmailPage extends StatefulWidget {
  User user;
  EmailPage(this.user);



  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;



  bool isverify;

  @override
  void initState() {
    // TODO: implement initState
    isverify=widget.user.emailVerified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('인증 실패'),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: (){
                _signOut();
              }
          ),

        ],
        leading:
        IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              _signOut();
            }
        ),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.user.email),
            Padding(padding: EdgeInsets.all(8)),
            Text('해당 계정의 이메일 인증이 완료되지 않았습니다\n이메일 인증을 완료해주세요',
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.all(8)),
            OutlinedButton(
              onPressed: () {
                widget.user.sendEmailVerification();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('본 메일로 이메일 인증 링크를 보냈습니다. 이메일 인증을 완료해주세요.'),
                  duration: const Duration(seconds: 10),
                  backgroundColor: Colors.blue,
                  action: SnackBarAction(
                    label: 'Done',
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ));

              },
              child: Text('인증메일 보내기'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            OutlinedButton(
              onPressed: () async{
                await widget.user.reload();
                widget.user = _auth.currentUser;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RootPage();
                }));
              },
              child: Text('인증 확인하기'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                ),
              ),
            ),


          ],
        ),
      ),
    );

  }
  void _signOut() async {
    await _firebaseAuth.signOut();
  }


}
