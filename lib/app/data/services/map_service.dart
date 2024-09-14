import 'dart:convert';
import 'dart:io';

import 'package:atelyam/app/data/models/map_model.dart';
import 'package:atelyam/app/data/services/auth_service.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MapService {
  final HomeController homeController = Get.put(HomeController());
  Future<List<MapModel>> getUsers() async {
    final List<MapModel> usersList = [];
    final String? sortID = await Auth().getToken();
    print(sortID);
    final response = await http.get(
      Uri.parse(
        'http://www.gps08.net/android/userapi.ashx?method=CarList&sortID=$sortID&pageindex=1&pagesize=1&mapType=BAIDU',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['list']['car'] as List;
      homeController.userList.clear();
      for (final Map product in responseJson) {
        usersList.add(MapModel.fromJson(product));
        homeController.userList.add(MapModel.fromJson(product));
      }

      return usersList;
    } else {
      return [];
    }
  }
}
