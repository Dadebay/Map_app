// // ignore_for_file: file_names, must_be_immutable, always_use_package_imports, avoid_void_async, non_constant_identifier_names

import 'package:atelyam/app/data/services/auth_service.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/app/modules/home/views/home_view.dart';
import 'package:atelyam/app/modules/profil/views/profil_view.dart';
import 'package:atelyam/app/modules/search/views/search_view.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:atelyam/constants/customWidget/custom_app_bar.dart';
import 'package:atelyam/constants/customWidget/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List page = [];
  final HomeController homeController = Get.put(HomeController());

  List pages = [const HomeView(), SearchView(), const ProfilView()];
  List names = ['home', 'search', 'profile'];
  String token = '';
  @override
  void initState() {
    super.initState();
    changeToken();

    _handleLocationPermission();
  }

  changeToken() async {
    token = (await Auth().getToken())!;
    setState(() {});
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar('Error', 'Location services are disabled. Please enable the services', Colors.red);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar('Error', 'Location permissions are denied', Colors.red);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar('Error', 'Location permissions are permanently denied, we cannot request permissions', Colors.red);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          return homeController.selectedIndex != 2
              ? const PreferredSize(preferredSize: Size.fromHeight(0), child: SizedBox.shrink())
              : CustomAppBar(
                  backArrow: false,
                  actionIcon: true,
                  centerTitle: true,
                  name: names[homeController.selectedIndex.value],
                );
        }),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            backgroundColor: Colors.white,
            iconSize: 22,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: kPrimaryColor,
            useLegacyColorScheme: true,
            selectedLabelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 13),
            unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, fontSize: 12),
            currentIndex: homeController.selectedIndex.value,
            onTap: (index) {
              setState(() => homeController.selectedIndex.value = index);
            },
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
          )),
      body: token.isEmpty
          ? Center(
              child: spinKit(),
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').doc(token).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return spinKit();
                }
                bool expiredValue = snapshot.data!['expireDate'] ?? false;
                if (expiredValue) {
                  return expiredScreen();
                } else {
                  return pagess();
                }
              }),
    );
  }

  Stack expiredScreen() {
    return Stack(
      children: [
        Positioned.fill(
          child: pagess(),
        ),
        Positioned.fill(
          child: Container(
            width: Get.size.width,
            height: Get.size.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.4),
            ),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Text(
              "expired".tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 28),
            ),
          ),
        ),
      ],
    );
  }

  Obx pagess() {
    return Obx(() => Center(
          child: pages[homeController.selectedIndex.value],
        ));
  }
}
