import 'package:flutter_dust/models/air_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
class AirBloc{

  final _airSubject = BehaviorSubject<AirResult>(); // BehaviorSubject: //Air_Result값을 제일 마지막을 밀어내는 기능

  AirBloc(){
    fetch();
  }

  // 비동기로 데이터를 얻어서 가져온다.
  Future<dynamic> fetchData() async {
    print('fetch');
    var toUri = Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=8a092729-a723-4c7e-befa-50e6921a48fb');
    var response = await http.get(toUri);

    // 공기 결과
    AirResult result = AirResult.fromJson(json.decode(response.body));

    if(result.data != null){
      return result;
    } else {
      return null;
    }
  }


  void fetch() async {
    var airResult = await fetchData(); // await 비동기 데이터를 사용하기 위해서
    _airSubject.add(airResult); //마지막 데이터가 비동기로들어간다.
  }
  Stream<AirResult> get airResult => _airSubject.stream; // 에어 서브젝트 있는 스트림을 꺼내오며 마지막 값인 airResult 얻는다.. .

}