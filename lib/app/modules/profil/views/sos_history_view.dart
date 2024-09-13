import 'package:atelyam/constants/customWidget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SosHistoryView extends StatelessWidget {
  const SosHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: 'sosHistory'),
    );
  }
}
