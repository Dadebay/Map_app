import 'package:atelyam/constants/buttons/agree_button_view.dart';
import 'package:atelyam/constants/customWidget/custom_app_bar.dart';
import 'package:atelyam/constants/customWidget/custom_text_field.dart';
import 'package:atelyam/constants/customWidget/widgets.dart';
import 'package:flutter/material.dart';

class ProfilEdit extends StatelessWidget {
  ProfilEdit({super.key});
  TextEditingController userNameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "profile"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          CustomTextField(
            hintText: 'userName',
            controller: userNameController,
            focusNode: usernameFocusNode,
            requestfocusNode: passwordFocusNode,
          ),
          CustomTextField(
            hintText: 'userpassword',
            controller: passwordController,
            focusNode: passwordFocusNode,
            requestfocusNode: usernameFocusNode,
          ),
          AgreeButton(
              onTap: () {
                showSnackBar("Success", "You succesfully changed User data", Colors.green);
              },
              text: "agree")
        ],
      ),
    );
  }
}
