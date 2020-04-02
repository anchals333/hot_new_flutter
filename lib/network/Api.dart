import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hot_new/home/hot_tab_model.dart';
import 'package:hot_new/network/app_exception.dart';
import 'package:http/http.dart' as http;

const apiCategory = {
  'name': 'Currency',
  'route': 'currency',
};

class Api {
  BuildContext context;
  final HttpClient _httpClient = HttpClient();
  final String _baseUrl = 'https://www.reddit.com';      // Live URL

  Map<String, String> _formDataHeader = {
    "Content-type": "application/x-www-form-urlencoded"
  };

  Map<String, String> _jsonHeader = {
    "Content-type": "application/json"
  };


  Api(this.context);

  Future<dynamic> getHotList() async {
    var jsonResponse;
    try {
      final response = await http.get(_baseUrl + "/hot.json");

      jsonResponse = _returnResponse(response);
      print(jsonResponse);

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return jsonResponse;
  }

  Future<dynamic> getNewList() async {
    var jsonResponse;
    try {
      final response = await http.get(_baseUrl + "/new.json");

      jsonResponse = _returnResponse(response);
      print(jsonResponse);

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return jsonResponse;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }

  }
}
