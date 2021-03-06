import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final textEditingController1 = TextEditingController();
  final textEditingController2 = TextEditingController();

  User user = FirebaseAuth.instance.currentUser;

  @override
  void dispose(){
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Investing Game',
                style: TextStyle(fontSize: 35),
              ),
              Padding(padding: EdgeInsets.all(4)),
              Text('ICISTS',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.right,
              ),
              Padding(padding: EdgeInsets.all(8)),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: textEditingController1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: '이메일',
                          labelText: '이메일',
                          suffixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.redAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: textEditingController2,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '비밀번호',
                          labelText: '비밀번호',
                          suffixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  )
              ),
              Padding(padding: EdgeInsets.all(4)),
              Text('웹 진행과 관련된 문의사항 및 오류 등은 카톡 cthero1 또는 인스타 @_2002.jh_으로 바로 연락주세요', textAlign: TextAlign.center,),
              Padding(padding: EdgeInsets.all(4)),
              Container(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _handleSignIn();
                  },
                  child: Text('로그인'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return RegisterPage();
                        }));
                      },
                      child: Text('회원가입')
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Text(
                    '아이디/비밀번호 찾기',

                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );

  }

  void _handleSignIn() async{
    UserCredential user = await _auth.signInWithEmailAndPassword(email: textEditingController1.text, password: textEditingController2.text);
  }

}
