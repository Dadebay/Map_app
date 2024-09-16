import 'package:atelyam/app/data/models/map_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool agreeButton = false.obs;
  RxBool showDetails = false.obs;
  RxList<MapModel> searchList = <MapModel>[].obs;
  RxList<MapModel> userList = <MapModel>[].obs;
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
}
