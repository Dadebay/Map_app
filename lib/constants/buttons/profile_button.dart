// ignore_for_file: file_names

import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class ProfilButton extends StatelessWidget {
  final String name;
  final Function() onTap;
  final IconData icon;
  final bool lang;
  const ProfilButton({
    required this.name,
    required this.lang,
    required this.onTap,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String image = '';
    if (Get.locale!.languageCode == 'tm') {
      image = tmIcon;
    } else if (Get.locale!.languageCode == 'en') {
      image = engIcon;
    } else if (Get.locale!.languageCode == 'ru') {
      image = ruIcon;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        tileColor: kGreyColor2,
        shape: const RoundedRectangleBorder(borderRadius: borderRadius15),
        minVerticalPadding: 23,
        title: Text(
          name.tr,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
        ),
        leading: Container(
          padding: EdgeInsets.all(lang ? 2 : 8),
          decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.2), borderRadius: borderRadius15),
          child: lang
              ? ClipRRect(
                  borderRadius: borderRadius15,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: 35,
                    height: 35,
                  ),
                )
              : Icon(icon, color: kPrimaryColor),
        ),
        trailing: const Icon(IconlyLight.arrowRightCircle, color: kPrimaryColor),
      ),
    );
  }
}
