import 'package:flutter/material.dart';
import 'package:flutter_dust/models/AirResult.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

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
  AirResult? _result;

  // 비동기로 데이터를 얻어서 가져온다.
  Future<AirResult> fetchData() async {
    var toUri = Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=8a092729-a723-4c7e-befa-50e6921a48fb');
    var response = await http.get(toUri);

    // 공기 결과
    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  @override
  void initState() {
    super.initState();

    fetchData().then((airResult) {
      setState(() {
        _result = airResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _result == null
            ? CircularProgressIndicator()
            : Padding(
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
                                  Text('지역'),
                                  Text(
                                    '${_result?.data?.current?.pollution?.aqius}',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                  Text(
                                    getString(_result!),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              color: getColor(_result!),
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
                                      Image.network(
                                        'https://airvisual.com/images/${_result?.data?.current?.weather?.ic}.png',
                                        width: 32, // 넓이
                                        height: 32, // 높이
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ), //여백주기 16
                                      Text(
                                        '${_result?.data?.current?.weather?.tp}°',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Text(
                                      '습도 ${_result?.data?.current?.weather?.hu}%'),
                                  Text(
                                      '풍속 ${_result?.data?.current?.weather?.ws}m/s'),
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
                            onPressed: () {},
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
              ),
      ),
    );
  }

  Color getColor(AirResult result) {
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

  String getString(AirResult result) {
    if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 50) {
      return '좋음';
    } else if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 100) {
      return '보통';
    } else if (result.data?.current?.pollution?.aqius != null &&
        result.data!.current!.pollution!.aqius! <= 50) {
      return '나쁨';
    } else {
      return '최악';
    }
  }
}
