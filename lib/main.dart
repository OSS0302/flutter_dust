import 'package:flutter/material.dart';
import 'package:flutter_dust/bloc/air_bloc.dart';
import 'package:flutter_dust/models/air_result.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

final airBloc = AirBloc(); // 인헤리티드위젯이든 flutter Bloc등등 이있다 .

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
  Air_Result? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<Air_Result>(
          stream: airBloc.airResult, //에어블럭에서 데이터가져오기
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return buildbody(snapshot.data );
            }else{
             return CircularProgressIndicator();
            }
          }
        ),
      ),
    );
  }

  Widget buildbody(Air_Result result) {
    return Padding(
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text('지역:${result?.data?.city}'),
                                Text(
                                  '${result?.data?.current?.pollution?.aqius}',
                                  style: TextStyle(fontSize: 40),
                                ),
                                Text(
                                  getString(result!),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            color: getColor(result!),
                            padding: const EdgeInsets.all(8.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    result?.data?.current?.weather?.ic != null ? Image.network(
                                      'https://airvisual.com/images/${result?.data?.current?.weather?.ic}.png',
                                      width: 32, // 넓이
                                      height: 32, // 높이
                                    ) : Container(),
                                    SizedBox(
                                      width: 16,
                                    ), //여백주기 16
                                    Text(
                                      '${result?.data?.current?.weather?.tp ?? ''}°',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text(
                                    '습도 ${result?.data?.current?.weather?.hu}%'),
                                Text(
                                    '풍속 ${result?.data?.current?.weather?.ws}m/s'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ClipRRect(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.orange),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                          onPressed: () {
                            setState(() {
                              result = null;
                              fetchData().then((airResult) {
                                if(airResult != null){
                                  setState(() {
                                    result = airResult;
                                  });
                                }
                              });
                            });
                          },
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
  }

  Color getColor(Air_Result result) {
    if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 50) {
      return Colors.greenAccent;
    } else if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 100) {
      return Colors.yellow;
    } else if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getString(Air_Result result) {
    if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 50) {
      return '좋음';
    } else if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 100) {
      return '보통';
    } else if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 150) {
      return '나쁨';
    } else {
      return '최악';
    }
  }

  fetchData() {}
}
