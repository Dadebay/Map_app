import 'package:atelyam/app/modules/profil/views/profil_edit_view.dart';
import 'package:atelyam/app/modules/profil/views/sos_history_view.dart';
import 'package:atelyam/constants/buttons/change_lang_button.dart';
import 'package:atelyam/constants/buttons/profile_button.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            ProfilButton(
              name: 'profile',
              lang: false,
              onTap: () {
                Get.to(() => ProfilEdit());
              },
              icon: IconlyLight.profile,
            ),
            ProfilButton(
              name: 'select_language',
              lang: true,
              onTap: () {
                changeLanguage();
              },
              icon: IconlyLight.setting,
            ),
            ProfilButton(
              name: 'sosHistory',
              lang: false,
              onTap: () {
                Get.to(() => SosHistoryView());
              },
              icon: IconlyLight.document,
            ),
          ],
        ));
  }

  void changeLanguage() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Text(
                    'select_language'.tr,
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                  ),
                ],
              ),
            ),
            ChangeLangButton(index: 0),
            ChangeLangButton(index: 1),
            ChangeLangButton(index: 2),
          ],
        ),
      ),
    );
  }
}
