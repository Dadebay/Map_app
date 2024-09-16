import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'constants.dart';

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  if (SnackbarController.isSnackbarBeingShown) {
    SnackbarController.cancelAllSnackbars();
  }
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.FLOATING,
    titleText: title == ''
        ? const SizedBox.shrink()
        : Text(
            title.tr,
            style: const TextStyle(fontFamily: gilroySemiBold, fontSize: 18, color: Colors.white),
          ),
    messageText: Text(
      subtitle.tr,
      style: const TextStyle(fontFamily: gilroyRegular, fontSize: 16, color: Colors.white),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: color,
    borderRadius: 20.0,
    duration: const Duration(milliseconds: 800),
    margin: const EdgeInsets.all(8),
  );
}

Center spinKit() {
  return Center(
    child: Lottie.asset(loadingLottie, width: 70.w, height: 70.h),
  );
}

Center errorData() {
  return const Center(
    child: Text("Error data"),
  );
}

Center emptyData() {
  return Center(
      child: Text(
    "noProduct".tr,
    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20.sp),
  ));
}

showUserInfo({
  required String name,
  required String tel,
  required String itvTime,
  required String howMuchKM,
}) {
  Get.defaultDialog(
      backgroundColor: Colors.white,
      title: 'userInfo'.tr,
      titleStyle: TextStyle(fontFamily: gilroySemiBold, fontSize: 22),
      titlePadding: EdgeInsets.only(top: 10, bottom: 10),
      contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidgetRow(text1: "${'userName'.tr} : ", text2: name),
          textWidgetRow(text1: "${'phoneNumber'.tr} : ", text2: tel),
          textWidgetRow(text1: "${'lastSeen'.tr} ", text2: itvTime),
          textWidgetRow(text1: "${'distance'.tr} ", text2: howMuchKM),
        ],
      ));
}

Widget textWidgetRow({required String text1, required String text2}) {
  return Container(
    width: Get.size.width / 1.2,
    padding: const EdgeInsets.only(top: 4, bottom: 4),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey, fontSize: 18, fontFamily: gilroyMedium),
          ),
        ),
        Expanded(
          child: Text(
            text2,
            maxLines: 2,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: gilroySemiBold),
          ),
        ),
      ],
    ),
  );
}
