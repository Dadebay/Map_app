import 'dart:convert';

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
  TextEditingController sortIDController = TextEditingController();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode sortIDFocusNode = FocusNode();

  TextEditingController passwordController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getData();
  }

  dynamic getData() async {
    await Auth().getData().then((a) {
      final responseJson = json.decode(a.toString());
      userNameController.text = responseJson['username'];
      passwordController.text = responseJson['headImg'];
      sortIDController.text = responseJson['id'];
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
            hintText: 'ID',
            disabled: false,
            controller: sortIDController,
            focusNode: sortIDFocusNode,
            requestfocusNode: usernameFocusNode,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomTextField(
              hintText: 'userName',
              disabled: false,
              controller: userNameController,
              focusNode: usernameFocusNode,
              requestfocusNode: passwordFocusNode,
            ),
          ),
        ],
      ),
    );
  }
}
