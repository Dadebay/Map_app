import 'dart:math';

import 'package:atelyam/app/data/models/map_model.dart';
import 'package:atelyam/app/data/models/sos_model.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class EnableButtonSlidable extends StatelessWidget {
  EnableButtonSlidable({super.key, required this.rightOrLeftSide, required this.disableShow, required this.model});
  final bool rightOrLeftSide;
  final HomeController homeController = Get.put(HomeController());

  final MapModel model;
  final bool disableShow;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (disableShow == true) {
            homeController.userList.forEach((e) {
              if (e.enableSOS == true && e.imei.toString() == model.imei.toString()) {
                e.enableSOS = false;
                homeController.userList.refresh();
                return;
              }
            });
          } else {
            DateTime now = DateTime.now();
            String beginDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day} ${now.hour}:${now.minute}";
            //get random id
            Random random = Random();
            int randomNumber = 100000000 + random.nextInt(900000000);
            final test = SOSModel(
                id: randomNumber,
                sendName: "",
                title: "SOS求救(${model.gpsName})",
                sendID: model.imei,
                sendTime: beginDate,
                isread: "False",
                content: "SOS求救,请关注!",
                lat: model.lat,
                long: model.long,
                typeId: "2");
            homeController.addToSosList(model: test);
          }
        },
        child: Container(
          height: Get.size.height,
          margin: EdgeInsets.only(left: rightOrLeftSide ? 5 : 15, top: 10, bottom: 10, right: rightOrLeftSide ? 15 : 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: disableShow ? Colors.red : Colors.green, borderRadius: borderRadius20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                IconlyLight.infoSquare,
                color: Colors.white,
              ),
              Text(
                disableShow ? "Disable" : "Enable",
                style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
