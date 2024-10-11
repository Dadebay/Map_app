import 'package:atelyam/app/data/models/map_model.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/constants/cards/search_card.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final HomeController homeController = Get.put(HomeController());
  TextEditingController textEditingController = TextEditingController();

  onSearchTextChanged(String word) async {
    List<MapModel> productsList = homeController.userList;
    List<MapModel> fullData = [];
    List<String> words = word.toLowerCase().trim().split(' ');
    fullData = productsList.where((p) {
      bool result = false;
      for (final word in words) {
        if (RegExp(r'^[0-9]+$').hasMatch(word)) {
          if (p.tel.toLowerCase().contains(word)) {
            result = true;
          }
        } else {
          if (p.gpsName.toLowerCase().contains(word.toLowerCase())) {
            result = true;
          }
        }
      }
      return result;
    }).toList();
    fullData.forEach((p) => print(p.tel));
    homeController.searchList.value = fullData.toSet().toList();
  }

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
          element.howMuchMETR = distance.toStringAsFixed(0);
          if (distance > 1000.0) {
            double km = (distance / 1000).floorToDouble();
            double meters = distance % 1000;
            element.howMuchKM = '${km.toStringAsFixed(0)} km ${meters.toStringAsFixed(0)} m';
          } else {
            element.howMuchKM = '${distance.toStringAsFixed(0)} m';
          }
        }
        homeController.userList.sort((a, b) => double.parse(a.howMuchMETR.toString()).compareTo(double.parse(b.howMuchMETR.toString())));
        homeController.userList.sort((a, b) => (b.enableSOS ? 1 : 0) - (a.enableSOS ? 1 : 0));
        return Column(
          children: [
            searchWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: homeController.searchList.isEmpty ? homeController.userList.length : homeController.searchList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return homeController.userList[index].gpsName == 'Dadebay'
                      ? const SizedBox.shrink()
                      : SearchCard(
                          model: homeController.searchList.isEmpty ? homeController.userList[index] : homeController.searchList[index],
                        );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Padding searchWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight + 10, left: 10, bottom: 10, right: 10),
      child: TextFormField(
        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
        cursorColor: Colors.black,
        controller: textEditingController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'errorEmpty'.tr;
          }
          return null;
        },
        onChanged: (value) => onSearchTextChanged(value),
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle: const TextStyle(fontFamily: gilroyMedium),
          hintMaxLines: 5,
          helperMaxLines: 5,
          suffixIcon: const Icon(
            IconlyLight.search,
            color: Colors.black,
          ),
          hintText: 'search'.tr,
          hintStyle: TextStyle(color: Colors.grey.shade300, fontFamily: gilroyMedium),
          contentPadding: const EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 10),
          border: const OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: borderRadius15,
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
