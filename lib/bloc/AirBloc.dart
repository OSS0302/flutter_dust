class AirBloc{
  // 비동기로 데이터를 얻어서 가져온다.
  Future<dynamic> fetchData() async {
    var toUri = Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=8a092729-a723-4c7e-befa-50e6921a48fb');
    var response = await http.get(toUri);

    // 공기 결과
    AirResult result = AirResult.fromJson(json.decode(response.body));

    if(result.data != null){
      print(result.data!.current.toString());
      return result;
    } else {
      return null;
    }
  }

}