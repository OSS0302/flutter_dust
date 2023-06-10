import 'package:flutter/material.dart';
import 'package:flutter_dust/models/AirResult.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // air 결과 값 가져오기
   late AirResult _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(
                '현재 위치 미세먼지',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              child: Column(
                children: <Widget>[
                   Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget> [
                        Text('지역'),
                        Text('${_result.data?.current?.pollution?.aqius}',
                          style: TextStyle(fontSize: 40),),
                        Text('보통',style: TextStyle(fontSize: 20),),
                      ],
                    ),
                    color: Colors.yellow,
                     padding: const EdgeInsets.all(8.0),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceAround,
                      children: <Widget> [
                        Row(
                          children: [
                            Text('이미지'),
                            SizedBox(
                              width: 16,
                            ),//여백주기 16
                            Text('11°',style:  TextStyle(fontSize: 16),),
                          ],
                        ),
                        Text('습도 100%'),
                        Text('풍속 5.7m/s'),
              ],
            ),
                )
              ],),
            ),
            ClipRRect(

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                child: ElevatedButton(

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    shape:
                      MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)))

                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],),
        ),
      ),
    );
  }
}
