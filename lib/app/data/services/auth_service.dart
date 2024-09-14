import 'dart:convert';
import 'dart:io';

import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/constants/customWidget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final HomeController homeController = Get.put(HomeController());

  Future login({required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('http://www.gps08.net/android/userapi.ashx?method=logUser&username=Dadebay&pwd=123456&type=1'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': "logUser",
        'username': username,
        'pwd': password,
        'type': '1',
      }),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson['id']);
      await Auth().setData(responseJson);
      await Auth().setToken(responseJson['id']);
      showSnackBar('Success', "You are logged in babe", Colors.green);
      return response.statusCode;
    } else {
      return response.statusCode;
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
