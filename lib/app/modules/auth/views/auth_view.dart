import 'package:atelyam/app/data/services/auth_service.dart';
import 'package:atelyam/app/modules/home/controllers/home_controller.dart';
import 'package:atelyam/app/modules/home/views/bottom_nav_bar.dart';
import 'package:atelyam/constants/buttons/agree_button_view.dart';
import 'package:atelyam/constants/customWidget/constants.dart';
import 'package:atelyam/constants/customWidget/custom_text_field.dart';
import 'package:atelyam/constants/customWidget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode1 = FocusNode();
  final HomeController homeController = Get.put(HomeController());
  final login = GlobalKey<FormState>();

  AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'login'.tr,
            style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 24),
          ),
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: login,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 25),
                  decoration: BoxDecoration(borderRadius: borderRadius30, boxShadow: [BoxShadow(color: kPrimaryColor.withOpacity(0.2), spreadRadius: 5, blurRadius: 3)]),
                  child: ClipRRect(
                    borderRadius: borderRadius30,
                    child: Image.asset(
                      logo,
                      height: Get.size.height / 4,
                      width: Get.size.height / 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              CustomTextField(hintText: "userName", controller: userNameEditingController, focusNode: focusNode, requestfocusNode: focusNode1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextField(hintText: "userpassword", controller: passwordEditingController, focusNode: focusNode1, requestfocusNode: focusNode),
              ),
              Center(
                child: AgreeButton(
                    onTap: () async {
                      if (login.currentState!.validate()) {
                        homeController.agreeButton.value = true;
                        await AuthService().login(username: userNameEditingController.text, password: passwordEditingController.text).then((a) {
                          if (a.toString() == '200') {
                            Get.to(() => const BottomNavBar());
                          } else {
                            showSnackBar('loginError', 'errorData', Colors.red);
                            userNameEditingController.clear();
                            passwordEditingController.clear();
                          }
                          homeController.agreeButton.value = false;
                        });
                      } else {
                        showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                      }
                    },
                    text: 'login'),
              )
            ],
          ),
        ));
  }
}
