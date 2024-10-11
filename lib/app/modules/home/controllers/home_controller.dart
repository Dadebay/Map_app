import 'dart:convert';

import 'package:atelyam/app/data/models/map_model.dart';
import 'package:atelyam/app/data/models/sos_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  RxBool agreeButton = false.obs;
  RxBool showDetails = false.obs;
  RxList<MapModel> searchList = <MapModel>[].obs;
  RxList<MapModel> userList = <MapModel>[].obs;
  RxList<SOSModel> sosLIST = <SOSModel>[].obs;
  RxDouble userCurrentLat = 0.0.obs;
  RxInt selectedIndex = 0.obs;
  final MapController mapController = MapController();

  RxDouble userCurrentLong = 0.0.obs;
  RxString sortID = ''.obs;
  Future<void> addOrUpdateUser({required String userId, required String userName, required String password}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot userDoc = await users.doc(userId).get();

    if (userDoc.exists) {
    } else {
      await users.doc(userId).set({
        'userID': userId,
        'userName': userName,
        'password': password,
        'expireDate': false,
      });
    }
  }

  final storage = GetStorage();

  // void addToSosList({required SOSModel model}) {
  //   print(model.id);
  //   if (!sosLIST.any((element) => element.id == model.id)) {
  //     sosLIST.add(model);
  //     print("Barik geldi __________________________________________________________________________");
  //     if (model.isread == false) {
  //       userList.forEach((e) {
  //         e.enableSOS = true;
  //       });
  //     }
  //   }
  // }

  void addToSosList({required SOSModel model}) {
    if (sosLIST.isEmpty) {
      sosLIST.add(model);
    } else {
      bool value = false;
      for (final element in sosLIST) {
        if (element.id == model.id) {
          value = true;
          return;
        }
      }
      if (!value) {
        print(sosLIST.length);
        sosLIST.add(model);
        print(sosLIST.length);

        userList.forEach((e) {
          if (e.imei == model.sendID) {
            e.enableSOS = true;
          }
        });
      }
    }
    sosLIST.refresh();
    userList.refresh();
    final String jsonString = jsonEncode(sosLIST);
    storage.write('sosList', jsonString);
  }

  addSosListToStorage() {
    sosLIST.refresh();
    print('_____________________________________________________________________');
    print(sosLIST);
    print('_____________________________________________________________________');

    final String jsonString = jsonEncode(sosLIST);
    storage.write('sosList', jsonString);
  }

  List<SOSModel> returnSosList() {
    final result = storage.read('sosList') ?? '[]';
    final List jsonData = jsonDecode(result);
    sosLIST.clear();
    sosLIST.addAll(jsonData.map((e) => SOSModel.fromJson(e)).toList());
    print('_____________________________________________________________________');
    print(sosLIST);
    print('_____________________________________________________________________');
    return sosLIST;
  }
}
