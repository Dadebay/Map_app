import 'dart:math';

import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class SearchCard extends StatelessWidget {
  SearchCard({super.key, required this.index});
  final int index;
  List names = [
    'Kerimow Aman ',
    'Abayewa Jemal',
    'Çaryýewa Aýnur',
    'Mekanow Aman',
    'Saparowa Güljemal',
    'Nazarowa Aýlar',
    'Radajabow Hekim',
    'Hojaglyýew Didar',
  ];
  List colors = [
    Colors.red,
    Colors.red,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
  ];
  List mphList = [
    '300',
    '24',
    '560',
    '380',
    '32',
    '21',
    '29',
    '152',
  ];
  List battery = [
    '80',
    '95',
    '75',
    '98',
    '10',
    '76',
    '89',
    '99',
  ];
  List numBerList = [
    '+966-592-241-111',
    '+966-592-241-748',
    '+966-592-241-698',
    '+966-592-241-289',
    '+966-592-241-147',
    '+966-592-241-698',
    '+966-592-241-698',
    '+966-592-241-547',
  ];
  @override
  Widget build(BuildContext context) {
    Random random = Random();

    int min = random.nextInt(3);
    int sec = random.nextInt(30);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: Get.size.width,
      decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius15, boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 3, spreadRadius: 3)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(color: colors[index], borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
            height: 110,
            width: 15,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        names[index],
                        style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: gilroySemiBold),
                      ),
                      Text(
                        "${mphList[index]} m",
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: gilroySemiBold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.wifi,
                          color: Colors.black,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Soňky mag: $min min $sec s",
                          style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: gilroyRegular),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Icon(
                              IconlyLight.call,
                              color: Colors.black,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              numBerList[index],
                              style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: gilroyRegular),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${battery[index]} % ",
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: gilroySemiBold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
