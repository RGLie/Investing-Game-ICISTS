import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investing_game_icists/tab_page.dart';

class InputPage extends StatefulWidget {
  User user;
  InputPage(this.user);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _teamController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose(){
    _nameController.dispose();
    _nicknameController.dispose();
    _phoneController.dispose();
    _teamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('개인정보 수정'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text('개인정보 입력이 완료되지 않았습니다.\n개인정보를 입력해주세요.'),
                      Padding(padding: EdgeInsets.all(10)),
                      Text('이메일 : ${widget.user.email}'),
                      Padding(padding: EdgeInsets.all(10)),
                      widget.user.emailVerified? Text('이메일 인증 완료됨'): Text('이메일 인증 완료되지 않음'),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: '이름',
                          labelText: '이름',
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
                            return "이름을 입력해주세요";
                          }

                          return null;
                        },
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: _nicknameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: '닉네임',
                          labelText: '닉네임',
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
                            return "닉네임을 입력해주세요";
                          }
                          else if(value.length>6){
                            return "닉네임은 5자 이내로 설정해주세요";
                          }
                          return null;
                        },
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '전화번호',
                          labelText: '전화번호',
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
                            return "전화번호를 입력해주세요";
                          }
                          else if(value.length!=11){
                            return "전화번호 형식이 올바르지 않습니다";
                          }
                          return null;
                        },
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: _teamController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: '팀',
                          labelText: '팀',
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
                          if (value.isEmpty){
                            return "팀을 입력해주세요";
                          }
                          else{
                            return null;
                          }
                        },

                      ),
                      Padding(padding: EdgeInsets.only(top:5)),
                      Text('오프라인 참가팀은 \'[오프라인]N팀\' 형식으로, \n온라인 참가팀 \'[온라인]N팀\' 형식으로,\n온라인 참가자는 \'[온라인]개인\'으로 입력해주세요.'
                      '\n\nex) 오프라인 0팀 -> [오프라인]0팀'),
                      Padding(padding: EdgeInsets.all(10)),

                      Container(
                        width: double.infinity,
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            if (_formKey.currentState.validate()) {
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
                                          new Text("개인 정보 확인"),

                                        ],
                                      ),
                                      //
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('이름 : ${_nameController.text}'),
                                          Text('닉네임 : ${_nicknameController.text}'),
                                          Text('전화번호 : ${_phoneController.text}'),
                                          Text('팀 : ${_teamController.text}'),

                                          Padding(padding: EdgeInsets.all(8)),
                                          Text('일부 정보는 수정이 어려울 수 있습니다.\n해당 정보를 등록할까요?')

                                        ],
                                      ),
                                      actions: <Widget>[
                                        new TextButton(
                                            child: new Text("등록"),
                                            onPressed: () async{
                                              widget.user.updateDisplayName(_nameController.text);

                                              await widget.user.reload();
                                              widget.user = _auth.currentUser;

                                              /*_reload();*/

                                              CollectionReference users = FirebaseFirestore.instance.collection('users');
                                              CollectionReference basics = FirebaseFirestore.instance.collection('trade_state');
                                              basics.doc('basic_assets').get()
                                              .then((DocumentSnapshot ds){
                                                  users.doc(widget.user.uid).set({
                                                    'full_name': _nameController.text,
                                                    'nick_name': _nicknameController.text,
                                                    'phone_number': _phoneController.text,
                                                    'team': _teamController.text,
                                                    'uid':widget.user.uid,
                                                    'money' : ds['money'],
                                                    '1_isTrade':false,
                                                    '2_isTrade':false,
                                                    '3_isTrade':false,
                                                    '4_isTrade':false,
                                                    '5_isTrade':false,
                                                    '6_isTrade':false,
                                                    '7_isTrade':false,
                                                    '8_isTrade':false,
                                                    'startup_1_stocks' : ds['stocks'],
                                                    'startup_2_stocks' : ds['stocks'],
                                                    'startup_3_stocks' : ds['stocks'],
                                                    'startup_4_stocks' : ds['stocks'],
                                                    'startup_5_stocks' : ds['stocks'],
                                                    'startup_6_stocks' : ds['stocks'],
                                                    'startup_7_stocks' : ds['stocks'],
                                                    'startup_8_stocks' : ds['stocks'],
                                                    'quiz_num' : 0,
                                                    'quiz_right': 0,
                                                    'quiz_wrong':0,
                                                    'quiz_state':false
                                                  });
                                              });

                                              /*FirebaseFirestore.instance.collection('student').document('kim').get().then(
                                              (DocumentSnapshot ds) {
                                              if (name == ds.data['name']) {
                                              // 실행할 구문 추가
                                              });*/
                                              Navigator.pop(context);
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return TabPage(widget.user);
                                              }));

                                            }
                                        ),
                                        new TextButton(
                                            child: new Text("뒤로"),
                                            onPressed: () {
                                              Navigator.pop(context);

                                            }
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
                          child: Text('입력 완료'),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _reload() async{
    await widget.user.reload();
    widget.user = FirebaseAuth.instance.currentUser;
  }
}