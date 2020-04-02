


import 'package:flutter/cupertino.dart';
import 'package:hot_new/home/hot_tab_model.dart';
import 'package:hot_new/network/Api.dart';
import 'package:hot_new/network/app_exception.dart';

class HotTabRepo{
  Api _apiProvider;

  Future<List<HotModel>> getHotList(BuildContext context) async {
    _apiProvider = Api(context);
    final response = await _apiProvider.getHotList();
    if (response['data'] != null) {
      var json = response['data'];
      var jsonList = json['children'] as List;
      return jsonList
          .map((jsonValue) => HotModel.fromJson(jsonValue))
          .toList();
    } else {
      throw FetchDataException('No data found!!!');
    }
  }
}