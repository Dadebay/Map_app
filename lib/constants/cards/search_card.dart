import 'package:atelyam/app/data/models/map_model.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:atelyam/constants/customWidget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class SearchCard extends StatelessWidget {
  final MapModel model;
  final HomeController homeController = Get.put(HomeController());

  SearchCard({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.selectedIndex.value = 0;

        List<LatLng> points = [];
        LatLng location = LatLng(double.parse(model.lat), double.parse(model.long));
        homeController.mapController.move(location, homeController.mapController.camera.zoom + 1);
        showUserInfo(
          name: model.gpsName,
          tel: model.tel,
          itvTime: model.itvtime,
          howMuchKM: model.howMuchKM,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: Get.size.width,
        decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius15, boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 3, spreadRadius: 3)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
              height: 110,
              width: 15,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          model.gpsName ?? 'Unknown',
                          style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroySemiBold),
                        ),
                        Text(
                          model.howMuchKM,
                          style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: gilroySemiBold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            IconlyBold.call,
                            color: Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            model.tel ?? 'Unknown',
                            style: const TextStyle(color: Colors.grey, fontSize: 16, fontFamily: gilroyMedium),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.wifi,
                                color: Colors.grey,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "lastSeen".tr + " ${model.itvtime} ",
                                style: const TextStyle(color: Colors.grey, fontSize: 16, fontFamily: gilroyMedium),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${model.vol} % ",
                          style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: gilroySemiBold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
