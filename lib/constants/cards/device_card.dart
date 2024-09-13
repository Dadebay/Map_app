import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(12),
      width: Get.size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius15,
          border: Border.all(color: kPrimaryColor.withOpacity(0.6), width: 1),
          boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.1), blurRadius: 3, spreadRadius: 3)]),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: customText(text: 'Imei :', text1: "869665067440727")),
              GestureDetector(
                  onTap: () {
                    showDeleteDialog();
                  },
                  child: const Icon(
                    IconlyLight.delete,
                    color: Colors.black,
                  ))
            ],
          ),
          customText(text: "${'clientNumber'.tr} :", text1: "+966-592-241-748"),
          customText(text: "${'userName'.tr} : ", text1: "User name field"),
        ],
      ),
    );
  }

  showDeleteDialog() {
    Get.defaultDialog(
        title: 'deleteTitle'.tr,
        titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroyBold),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'deleteSubtitle'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: gilroyMedium),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, elevation: 0, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                      onPressed: () {},
                      child: Text(
                        "no".tr,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: gilroyBold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, elevation: 0, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                      child: Text(
                        "yes".tr,
                        style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: gilroyMedium),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget customText({
    required String text,
    required String text1,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.grey, fontSize: 18, fontFamily: gilroyMedium),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text1,
            style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: gilroyMedium),
          ),
        ],
      ),
    );
  }
}
