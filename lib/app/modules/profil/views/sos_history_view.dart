import 'package:atelyam/app/data/models/sos_model.dart';
import 'package:atelyam/app/data/services/map_service.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/app/modules/profil/views/show_sos_view_in_map.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:atelyam/constants/customWidget/custom_app_bar.dart';
import 'package:atelyam/constants/customWidget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SosHistoryView extends StatelessWidget {
  SosHistoryView({super.key});
  final HomeController homeController = Get.put<HomeController>(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: 'sosHistory'),
      body: FutureBuilder<List<SOSModel>>(
          future: MapService().getSosMessages(),
          builder: (BuildContext context, AsyncSnapshot<List<SOSModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return spinKit();
            } else if (snapshot.hasData) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 6),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  String phoneNumber = "";
                  homeController.userList.forEach((element) {
                    if (element.imei == snapshot.data![index].sendID) {
                      phoneNumber = element.tel;
                    }
                  });
                  return customCard(snapshot, index, phoneNumber);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    child: Divider(),
                  );
                },
              );
            }
            ;

            return const Text("Error");
          }),
    );
  }

  Widget customCard(AsyncSnapshot<List<SOSModel>> snapshot, int index, String phone) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ShowSosViewInMap(
              latitude: snapshot.data![index].lat,
              longtitude: snapshot.data![index].long,
            ));
      },
      child: Column(
        children: [
          customTextField(name: 'Name', data: snapshot.data![index].title),
          customTextField(name: 'Device id', data: snapshot.data![index].sendID),
          customTextField(name: 'Time', data: snapshot.data![index].sendTime),
          customTextField(name: 'Phone', data: phone),
        ],
      ),
    );
  }

  Widget customTextField({required String name, required String data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                name + ' :',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 16),
              )),
          Expanded(
              flex: 2,
              child: Text(
                data,
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 16),
              ))
        ],
      ),
    );
  }
}
