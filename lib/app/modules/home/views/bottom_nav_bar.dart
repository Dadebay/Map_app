// // ignore_for_file: file_names, must_be_immutable, always_use_package_imports, avoid_void_async, non_constant_identifier_names

import 'package:atelyam/app/modules/home/views/home_view.dart';
import 'package:atelyam/app/modules/profil/views/profil_view.dart';
import 'package:atelyam/app/modules/search/views/search_view.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:atelyam/constants/customWidget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List page = [];
  int selectedIndex = 0;

  List pages = [const HomeView(), SearchView(), const ProfilView()];
  List names = ['home', 'search', 'profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backArrow: false,
        actionIcon: true,
        centerTitle: true,
        name: names[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kPrimaryColor,
        useLegacyColorScheme: true,
        selectedLabelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, fontSize: 12),
        currentIndex: selectedIndex,
        onTap: (index) async => setState(() => selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.location),
            activeIcon: const Icon(IconlyBold.location),
            label: 'home'.tr,
            tooltip: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.search),
            activeIcon: const Icon(IconlyBold.search),
            label: 'search'.tr,
            tooltip: 'search'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.profile),
            activeIcon: const Icon(IconlyBold.profile),
            label: 'profile'.tr,
            tooltip: 'profile'.tr,
          ),
        ],
      ),
      body: Center(
        child: pages[selectedIndex],
      ),
    );
  }
}
