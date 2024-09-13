// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode requestfocusNode;

  const CustomTextField({
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.requestfocusNode,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
        cursorColor: Colors.black,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'errorEmpty'.tr;
          }
          return null;
        },
        maxLines: 1,
        focusNode: focusNode,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle: const TextStyle(fontFamily: gilroyMedium),
          hintMaxLines: 5,
          helperMaxLines: 5,
          hintText: hintText.tr,
          hintStyle: TextStyle(color: Colors.grey.shade300, fontFamily: gilroyMedium),
          contentPadding: const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 10),
          border: const OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: borderRadius20,
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}

class CustomSeachField extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  CustomSeachField({super.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
      cursorColor: Colors.black,
      controller: textEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'errorEmpty'.tr;
        }
        return null;
      },
      onEditingComplete: () {},
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorStyle: const TextStyle(fontFamily: gilroyMedium),
        hintMaxLines: 5,
        helperMaxLines: 5,
        hintText: 'search'.tr,
        hintStyle: TextStyle(color: Colors.grey.shade300, fontFamily: gilroyMedium),
        contentPadding: const EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 10),
        border: const OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: borderRadius15,
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
