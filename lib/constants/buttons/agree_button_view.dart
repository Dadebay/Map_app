// ignore_for_file: file_names, must_be_immutable

import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../customWidget/constants.dart';

class AgreeButton extends StatelessWidget {
  final Function() onTap;
  final String text;

  AgreeButton({super.key, required this.onTap, required this.text});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: animatedContaner());
  }

  Widget animatedContaner() {
    return Obx(() {
      return AnimatedContainer(
        decoration: const BoxDecoration(borderRadius: borderRadius20, color: kPrimaryColor),
        margin: const EdgeInsets.only(top: 15),
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: homeController.agreeButton.value ? 0 : 10.h),
        width: homeController.agreeButton.value ? 60.w : Get.size.width,
        duration: const Duration(milliseconds: 800),
        child: homeController.agreeButton.value
            ? Center(
                child: SizedBox(
                  width: 34.w,
                  height: 29.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
                text.tr,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 22.sp),
              ),
      );
    });
  }
}
