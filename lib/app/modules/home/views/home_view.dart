import 'package:atelyam/app/data/models/map_model.dart';
import 'package:atelyam/app/data/services/map_service.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:atelyam/constants/customWidget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());

  String _currentMapType = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  Position? _currentPosition;
  MapModel? _selectedUser;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    _future = MapService().getUsers();
  }

  Widget getData(AsyncSnapshot<List<MapModel>> snapshot) {
    homeController.userList.add(MapModel(
      id: '0',
      weidu: _currentPosition!.latitude.toString(),
      serTime: '',
      iconType: '',
      isOnline: '',
      lastTime: '',
      addre: '',
      lat: _currentPosition!.latitude.toString(),
      long: _currentPosition!.longitude.toString(),
      spe: "spe",
      dir: "dir",
      imei: "imei",
      tel: "+99362990344",
      gpsName: "Dadebay",
      sortID: "sortID",
      driveID: "driveID",
      strUID: "strUID",
      wlID: "wlID",
      pic: "pic",
      vol: "vol",
      vbt: "vbt",
      islac: "islac",
      sta: "sta",
      gprs: "gprs",
      gps: "gps",
      stateFlag: "stateFlag",
      itvtime: "itvtime",
      gpsTime: "gpsTime",
      sign: "sign",
      deviceType: "deviceType",
      howMuchKM: '0.0',
      jindu: _currentPosition!.longitude.toString(),
      howMuchMETR: '0.0',
      enableSOS: false,
    ));
    return Obx(() {
      for (var element in homeController.userList) {
        double startLatitude = _currentPosition!.latitude;
        double startLongitude = _currentPosition!.longitude;
        double endLatitude = double.parse(element.lat.toString()); // Replace with actual latitude
        double endLongitude = double.parse(element.long.toString()); // Replace with actual longitude
        double distance = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
        element.howMuchMETR = distance.toStringAsFixed(0);
        if (distance > 1000.0) {
          double km = (distance / 1000).floorToDouble();
          double meters = distance % 1000;
          element.howMuchKM = '${km.toStringAsFixed(0)} km ${meters.toStringAsFixed(0)} m';
        } else {
          element.howMuchKM = '${distance.toStringAsFixed(0)} m';
        }
      }
      return Stack(
        children: [
          map(),
          rightBottomIcons(),
        ],
      );
    });
  }

  Widget map() {
    return FlutterMap(
      mapController: homeController.mapController,
      options: MapOptions(
        initialCenter: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        initialZoom: 13,
        onTap: (_, __) {
          homeController.showDetails.value = false;
        },
      ),
      children: [
        TileLayer(
          urlTemplate: _currentMapType,
          userAgentPackageName: 'com.example.app',
          maxNativeZoom: 19,
        ),
        MarkerLayer(
          markers: List.generate(homeController.userList.length, (index) {
            return Marker(
              width: 25.0,
              height: 25.0,
              point: LatLng(double.parse(homeController.userList[index].lat.toString()), double.parse(homeController.userList[index].long.toString())),
              child: homeController.userList[index].gpsName != 'Dadebay'
                  ? GestureDetector(
                      onTap: () {
                        _selectedUser = homeController.userList[index];
                        homeController.showDetails.value = true;
                        if (homeController.showDetails.value && _selectedUser != null) {
                          showUserInfo(
                            name: _selectedUser!.gpsName,
                            tel: _selectedUser!.tel,
                            itvTime: _selectedUser!.itvtime,
                            howMuchKM: _selectedUser!.howMuchKM,
                          );
                        }
                      },
                      child: Icon(
                        Icons.location_history_rounded,
                        color: Colors.green,
                        size: 40,
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                    ),
            );
          }),
        ),
      ],
    );
  }

  Positioned rightBottomIcons() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  homeController.mapController.move(homeController.mapController.camera.center, homeController.mapController.camera.zoom + 1);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: kPrimaryColor),
                        right: BorderSide(color: kPrimaryColor),
                        left: BorderSide(color: kPrimaryColor),
                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: const Icon(
                    CupertinoIcons.add_circled,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  homeController.mapController.move(homeController.mapController.camera.center, homeController.mapController.camera.zoom - 1);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border.fromBorderSide(BorderSide(color: kPrimaryColor)),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                  child: const Icon(
                    CupertinoIcons.minus_circle,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _toggleMapType,
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius: borderRadius20, side: BorderSide(color: kPrimaryColor)),
            backgroundColor: Colors.white,
            child: Icon(
              _currentMapType == 'https://tile.openstreetmap.org/{z}/{x}/{y}.png' ? CupertinoIcons.map : CupertinoIcons.map_fill,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
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

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
        _currentPosition = position;
        homeController.userCurrentLat.value = position.latitude;
        homeController.userCurrentLong.value = position.longitude;
      });
    }).catchError((e) {});
  }

  void _toggleMapType() {
    setState(() {
      if (_currentMapType == 'https://tile.openstreetmap.org/{z}/{x}/{y}.png') {
        _currentMapType = 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png';
      } else {
        _currentMapType = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
      }
    });
  }

  Future<List<MapModel>>? _future;
  @override
  Widget build(BuildContext context) {
    return _currentPosition == null
        ? spinKit()
        : FutureBuilder<List<MapModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return spinKit();
              } else if (snapshot.hasData) {
                return getData(snapshot);
              }

              return const Text("asd");
            });
  }
}
