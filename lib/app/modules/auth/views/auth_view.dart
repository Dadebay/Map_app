import 'package:atelyam/app/data/services/auth_service.dart';
import 'package:atelyam/app/modules/home/views/bottom_nav_bar.dart';
import 'package:atelyam/constants/buttons/agree_button_view.dart';
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
  AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('AuthView'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            CustomTextField(hintText: "UserName", controller: userNameEditingController, focusNode: focusNode, requestfocusNode: focusNode1),
            CustomTextField(hintText: "Password", controller: passwordEditingController, focusNode: focusNode1, requestfocusNode: focusNode),
            AgreeButton(
                onTap: () async {
                  await AuthService().login(username: userNameEditingController.text, password: passwordEditingController.text).then((a) {
                    if (a.toString() == '200') {
                      Get.to(() => const BottomNavBar());
                    } else {
                      showSnackBar('Error', 'Please see your creadentials', Colors.red);
                    }
                  });
                },
                text: 'Agree')
          ],
        ));
  }
}
