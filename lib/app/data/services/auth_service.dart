import 'dart:convert';
import 'dart:io';

import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final HomeController homeController = Get.put(HomeController());

  Future login({required String username, required String password}) async {
    homeController.agreeButton.value = true;
    final response = await http.post(
      Uri.parse('http://www.gps08.net/android/userapi.ashx?method=logUser&username=${username}&pwd=${password}&type=1'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': "logUser",
        'username': username.toString(),
        'pwd': password.toString(),
        'type': '1',
      }),
    );
    if (response.body != "{}") {
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        responseJson['headImg'] = password;
        await Auth().setData(json.encode(responseJson));
        await Auth().setToken(responseJson['id']);
        homeController.addOrUpdateUser(userId: responseJson['id'], userName: username, password: password);
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } else {
      return 404;
    }
  }
}
// ignore_for_file: file_names, require_trailing_commas, avoid_void_async, avoid_bool_literals_in_conditional_expressions

class Auth {
  final storage = GetStorage();

  Future<bool> setData(String data) async {
    await storage.write('data', data);
    return storage.read('data') == null ? false : true;
  }

  Future<String?> getData() async {
    return storage.read('data');
  }

  Future<bool> logout() async {
    await storage.remove('AccessToken');
    return storage.read('AccessToken') == null ? true : false;
  }

  Future<bool> setToken(String token) async {
    await storage.write('AccessToken', token);
    return storage.read('AccessToken') == null ? false : true;
  }

  Future<String?> getToken() async {
    return storage.read('AccessToken');
  }
}
