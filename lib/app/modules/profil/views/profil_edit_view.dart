import 'package:atelyam/app/data/services/auth_service.dart';
import 'package:atelyam/constants/customWidget/custom_app_bar.dart';
import 'package:atelyam/constants/customWidget/custom_text_field.dart';
import 'package:flutter/material.dart';

class ProfilEdit extends StatefulWidget {
  const ProfilEdit({super.key});

  @override
  State<ProfilEdit> createState() => _ProfilEditState();
}

class _ProfilEditState extends State<ProfilEdit> {
  TextEditingController userNameController = TextEditingController();

  FocusNode usernameFocusNode = FocusNode();

  TextEditingController passwordController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  dynamic changeDATA() async {
    await Auth().getData().then((a) {
      print(a);
    });
  }

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
        ],
      ),
    );
  }
}
