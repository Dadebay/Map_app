import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ShowSosViewInMap extends StatefulWidget {
  const ShowSosViewInMap({super.key, required this.latitude, required this.longtitude});

  final String latitude;
  final String longtitude;

  @override
  State<ShowSosViewInMap> createState() => _ShowSosViewInMapState();
}

class _ShowSosViewInMapState extends State<ShowSosViewInMap> {
  final MapController mapController = MapController();

  String _currentMapType = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  void getData() {
    mapController.move(LatLng(double.parse(widget.latitude), double.parse(widget.longtitude)), 13);
    setState(() {});
  }

  Widget map() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(double.parse(widget.latitude), double.parse(widget.longtitude)),
        initialZoom: 13,
      ),
      children: [
        TileLayer(
          urlTemplate: _currentMapType,
          userAgentPackageName: 'com.example.app',
          maxNativeZoom: 19,
        ),
        MarkerLayer(markers: [
          Marker(
              width: 25.0,
              height: 25.0,
              point: LatLng(double.parse(widget.latitude), double.parse(widget.longtitude)),
              child: Icon(
                Icons.location_history_rounded,
                color: Colors.green,
                size: 40,
              ))
        ]),
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
                  mapController.move(mapController.camera.center, mapController.camera.zoom + 1);
                  setState(() {});
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
                  mapController.move(mapController.camera.center, mapController.camera.zoom - 1);
                  setState(() {});
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

  void _toggleMapType() {
    setState(() {
      if (_currentMapType == 'https://tile.openstreetmap.org/{z}/{x}/{y}.png') {
        _currentMapType = 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png';
      } else {
        _currentMapType = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        map(),
        rightBottomIcons(),
      ],
    );
    ;
  }
}
