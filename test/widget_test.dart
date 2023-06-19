import 'package:flutter/material.dart';
import 'package:flutter_dust/models/air_result.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dust/main.dart';

import 'dart:convert';

void main() {
  test('http 통신 테스트', () async {
    var toUri = Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=8a092729-a723-4c7e-befa-50e6921a48fb');
    var response = await http.get(toUri);

// 결과확인하기
    expect(response.statusCode, 200);

    // 공기 결과
    AirResult result = AirResult.fromJson(json.decode(response.body));// json 데이터는 response.body 에 있다. 그리고  바로 쓰면 안되고 디코딩해서 사용해야한다.
    expect(result.status,'success');
  });
}