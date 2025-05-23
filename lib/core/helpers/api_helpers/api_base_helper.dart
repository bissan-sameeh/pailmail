import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../storage/shared_prefs.dart';
import 'app_exception.dart';

class ApiBaseHelper {
  var responseJson;

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postDel(
    String url,
  ) async {
    var responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, Map<String, String> body) async {
    try {
      final response =
          await http.put(Uri.parse(url), body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return true;
  }

  Map<String, String> get headers {
    Map<String, String> header = <String, String>{};
    header[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPreferencesController().loggedIn) {
      header[HttpHeaders.authorizationHeader] =
          SharedPreferencesController().token;
    }
    return header;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        print(response.body);
        var responseJson = json.decode(response.body); //convert String to json

        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(jsonDecode(response.body));
      case 401:
      case 403:
        throw UnauthorisedException(jsonDecode(response.body));
      case 422:
        throw BadRequestException(jsonDecode(response.body));
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  // Future<dynamic> post(String url, Map<String, String> body) async {
  //
  //   postParams(
  //       String sender_url, bool params, Map<String, dynamic> body) async {
  //     var responseJson;
  //
  //     String url = '$sender_url/senders/?mail=$params';
  //     print("2");
  //     try {
  //       print("3");
  //       final response =
  //           await http.post(Uri.parse(url), headers: headers, body: body);
  //       print("4");
  //       responseJson = _returnResponse(response);
  //       print("5");
  //     } catch (e) {}
  //     ;
  //   } //E/flutter ( 8612): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Error During Communication: Error occurred while Communication with Server with StatusCode : 301
  // }

  Future<dynamic> postParams(
      String sender_url, bool params, Map<String, dynamic> body) async {
    String url = '$sender_url/senders/?mail=$params';
    print("2");
    try {
      print("3");
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print("4");
      responseJson = _returnResponse(response);
      print(
          "5"); //E/flutter ( 8612): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Error During Communication: Error occurred while Communication with Server
    } catch (e) {}
  }

  Future<dynamic> post(String url, Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      print("jeafhe${response.statusCode}");
      print("kkkkkkkkkkkkkkkkkkkkkkkkkkk${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getParam(
      String sender_url, String? id, String name, var params) async {
    String url = '$sender_url/$id?$name=$params';
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getParams(String sender_url, String name, var params) async {
    String url = '$sender_url?$name=$params';
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
