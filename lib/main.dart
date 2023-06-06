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
        child: Column(children: <Widget>[
          Text('현재 위치 미세먼지'),
          Card(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget> [
                    Text('지역'),
                    Text('80'),
                    Text('보통'),
                  ],
                ),
              Row(
                  children: <Widget> [
                    Text('지역'),
                    Text('80'),
                    Text('보통'),
            ],
          )
            ],),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange)
            ),
            onPressed: () {},
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],),
      ),
    );
  }
}
