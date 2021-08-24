import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var userStatus;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserCredential result;
  User user;

  @override
  void initState() {
    super.initState();
    setUserStatus();
  }
  Future<void> setUserStatus() async {
    userStatus = await FirebaseAuth.instance.currentUser;
    setState(() {});
  }
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    setUserStatus();
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('회원가입')),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8)),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "이메일을 입력해주세요";
                        }
                        return null;
                      },
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      controller: _passwordController,
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "비밀번호를 입력해주세요";
                        }
                        else if(value.length<6){
                          return "비밀번호가 짧습니다";
                        }
                        return null;
                      },
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '비밀번호 확인',
                        labelText: '비밀번호 확인',
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
                      validator: (String value){
                        if (value !=_passwordController.text){
                          return "비밀번호가 일치하지 않습니다";
                        }
                        else{
                          return null;
                        }
                      },
                    )
                  ],
                )
            ),
            Padding(padding: EdgeInsets.all(8)),
            Container(
              width: double.infinity,
              height: 60,
              child: OutlinedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (_formKey.currentState.validate()) {
                    _register();

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
                            title: Column(
                              children: <Widget>[
                                new Text("이메일 인증 알림"),

                              ],
                            ),
                            //
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${_emailController.text}'),
                                Text('해당 메일로 인증 링크를 보냈습니다.\n이메일 인증을 완료해주세요.')

                              ],
                            ),
                            actions: <Widget>[
                              new TextButton(
                                child: new Text("확인"),
                                onPressed: () {
                                  CollectionReference users = FirebaseFirestore.instance.collection('users');

                                  Navigator.pop(context);
                                  logout();
                                  _signOut();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });

                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('다시 시도하세요.'),
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
                child: Text('완료'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);

    user = result.user;

    if (user == null) {
      final snacBar = SnackBar(
        content: Text("Please try again later"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snacBar);
    }

    if (user!= null && !user.emailVerified) {
      await user.sendEmailVerification();
    }


  }

  void _signOut() async {
    await _firebaseAuth.signOut();
  }
}

