import 'dart:convert';
import 'package:buscamais/model/responseResult.dart';
import 'package:http/http.dart' as http;

Future<ResponseResult> get(method) async {
  var url = 'http://13.59.75.47:8083/api/';
  Map<String, String> headers ={
    "Content-Type": "application/json"
  };

  var response = await http.get(url + method, headers: headers);
  Map mapResponse = json.decode(response.body);
  return ResponseResult.fromJson(mapResponse);
}

Future<ResponseResult> post(method, body) async {
  var url = 'http://13.59.75.47:8083/api/';

  Map<String, String> headers ={
    "Content-Type": "application/json"
  };
  String s = json.encode(body);

  var response = await http.post(
      url + method,
      body: s,
      headers: headers);

  Map mapResponse = json.decode(response.body);
  return ResponseResult.fromJson(mapResponse);
}

Future<ResponseResult> put(method, body) async {
  var url = 'http://13.59.75.47:8083/api/';

  Map<String, String> headers ={
    "Content-Type": "application/json"
  };
  String s = json.encode(body);

  var response = await http.put(
      url + method,
      body: s,
      headers: headers);

  Map mapResponse = json.decode(response.body);
  return ResponseResult.fromJson(mapResponse);
}