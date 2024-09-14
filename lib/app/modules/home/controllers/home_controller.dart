import 'package:atelyam/app/data/models/map_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool agreeButton = false.obs;
  RxBool showDetails = false.obs;
  RxList<MapModel> userList = <MapModel>[].obs;
  RxDouble userCurrentLat = 0.0.obs;
  RxDouble userCurrentLong = 0.0.obs;
  RxString sortID = ''.obs;
}
