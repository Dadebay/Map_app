import 'dart:convert';
import 'dart:io';

import 'package:atelyam/app/data/models/map_model.dart';
import 'package:atelyam/app/data/models/sos_model.dart';
import 'package:atelyam/app/data/services/auth_service.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MapService {
  final HomeController homeController = Get.put(HomeController());
  Future<List<MapModel>> getUsers() async {
    final List<MapModel> usersList = [];
    final String? sortID = await Auth().getToken();
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
      await MapService().getSosMessages();

      return usersList;
    } else {
      return [];
    }
  }

  Future<List<SOSModel>> getSosMessages() async {
    final List sosList = [];
    final List<SOSModel> sosListReturnData = [];
    print(homeController.userList);
    homeController.userList.forEach((e) {
      sosList.add(e.imei);
    });
    print(sosList);

    await homeController.returnSosList();

    // Construct the strWhere parameter
    String strWhere = "replyId in(${sosList.map((imei) => "'$imei'").join(',')})";

    // Get the current date and format the first day of the current month
    DateTime now = DateTime.now();
    String beginDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-01";

    final response = await http.get(
      Uri.parse(
        "http://xcx.track110.com/android/userapi.ashx?method=DeviceMessage&strWhere=$strWhere&begin=$beginDate&pageIndex=1&pageSize=100",
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['data'] as List;
      for (final Map product in responseJson) {
        if (SOSModel.fromJson(product).typeId.toString() == '2') {
          homeController.addToSosList(model: SOSModel.fromJson(product));
          sosListReturnData.add(SOSModel.fromJson(product));
        }
      }
      homeController.addSosListToStorage();
      return sosListReturnData;
    } else {
      return [];
    }
  }
}
