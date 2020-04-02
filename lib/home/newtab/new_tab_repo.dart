


import 'package:flutter/cupertino.dart';
import 'package:hot_new/home/newtab/newtab_model.dart';
import 'package:hot_new/network/Api.dart';
import 'package:hot_new/network/app_exception.dart';


class NewTabRepo{
  Api _apiProvider;

  Future<List<NewModel>> getNewList(BuildContext context) async {
    _apiProvider = Api(context);
    final response = await _apiProvider.getNewList();
    if (response['data'] != null) {
      var json = response['data'];
      var jsonList = json['children'] as List;
      return jsonList
          .map((jsonValue) => NewModel.fromJson(jsonValue))
          .toList();
    } else {
      throw FetchDataException('No data found!!!');
    }
  }
}