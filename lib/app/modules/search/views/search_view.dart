import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/constants/cards/search_card.dart';
import 'package:atelyam/constants/customWidget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        for (var element in homeController.userList) {
          double startLatitude = homeController.userCurrentLat.value;
          double startLongitude = homeController.userCurrentLong.value;
          double endLatitude = double.parse(element.lat.toString()); // Replace with actual latitude
          double endLongitude = double.parse(element.long.toString()); // Replace with actual longitude
          double distance = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
          if (distance > 1000.0) {
            double km = (distance / 1000).floorToDouble();
            double meters = distance % 1000;
            element.howMuchKM = '${km.toStringAsFixed(0)} km ${meters.toStringAsFixed(0)} m';
          } else {
            element.howMuchKM = '${distance.toStringAsFixed(0)} m';
          }
        }
        return Column(
          children: [
            CustomSeachField(),
            Expanded(
              child: ListView.builder(
                itemCount: homeController.userList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return homeController.userList[index].gpsName == 'Dadebay'
                      ? const SizedBox.shrink()
                      : SearchCard(
                          model: homeController.userList[index],
                        );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
