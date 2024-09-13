import 'package:atelyam/constants/cards/device_card.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:atelyam/constants/customWidget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceListView extends StatelessWidget {
  const DeviceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addDeviceDialog();
        },
        backgroundColor: kPrimaryColor,
        label: Text(
          "addDevice".tr,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: gilroyBold),
        ),
      ),
      appBar: const CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: 'deviceList'),
      body: ListView.builder(
        itemCount: 8,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return DeviceCard(index: index);
        },
      ),
    );
  }

  addDeviceDialog() {
    Get.defaultDialog(
        title: 'addDevice'.tr,
        titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroyBold),
        content: Column(
          children: [
            // CustomTextField(hintText: 'Imei', controller: controller, focusNode: focusNode, requestfocusNode: requestfocusNode)
            // CustomTextField(hintText: 'clientNumber', controller: controller, focusNode: focusNode, requestfocusNode: requestfocusNode)
            // CustomTextField(hintText: 'userName', controller: controller, focusNode: focusNode, requestfocusNode: requestfocusNode)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, elevation: 0, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                  onPressed: () {},
                  child: Text(
                    "no".tr,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: gilroyBold),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
