import 'package:atelyam/app/modules/profil/controllers/profil_controller.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLangButton extends StatelessWidget {
  ChangeLangButton({required this.index, super.key});
  final int index;
  List icon = [tmIcon, ruIcon, engIcon];
  List lang = ['Türkmen dili', 'Rus dili', 'Iňlis dili'];
  List langText = ['tm', 'ru', 'en'];
  final ProfilController userProfilController = Get.put(ProfilController());
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: const Divider(
            color: backgroundColor,
            thickness: 2,
          ),
        ),
        ListTile(
          dense: true,
          minVerticalPadding: 0,
          onTap: () {
            userProfilController.switchLang(langText[index]);
            Get.back();
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              icon[index],
            ),
            backgroundColor: Colors.black,
            radius: 20,
          ),
          title: Text(
            lang[index],
            style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
