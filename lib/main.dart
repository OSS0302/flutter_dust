import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(
              '현재 위치 미세먼지',
            style: TextStyle(fontSize: 30),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget> [
                      Text('지역'),
                      Text('80',style: TextStyle(fontSize: 40),),
                      Text('보통',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  color: Colors.yellow,
                ),
              Row(
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
          )
            ],),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)
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
    );
  }
}
