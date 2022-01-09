import 'package:flutter/material.dart';

class QuizDetailPage extends StatefulWidget {

  @override
  _QuizDetailPageState createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Padding(
      padding:  EdgeInsets.all(15),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:5, bottom: 5, left: 40, right: 40),
              child: Text('아이시스츠(ICISTS)의 회장은 누구인가요?', textAlign: TextAlign.center ,style: TextStyle(fontSize: 30),),
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
                      },
                      child: Container(
                          height: 100,
                          child: Center(child: Text('1', style: TextStyle(color: Colors.black, fontSize: 20),))
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

                      },
                      child: Container(
                          height: 100,
                          child: Center(child: Text('2', style: TextStyle(color: Colors.black, fontSize: 20),))
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
                      },
                      child: Container(
                          height: 100,
                          child: Center(child: Text('3', style: TextStyle(color: Colors.black, fontSize: 20),))
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
                      },
                      child: Container(
                          height: 100,
                          child: Center(child: Text('4', style: TextStyle(color: Colors.black, fontSize: 20),))
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
}
