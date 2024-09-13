import 'package:atelyam/constants/cards/search_card.dart';
import 'package:atelyam/constants/customWidget/custom_text_field.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: CustomSeachField(),
          scrolledUnderElevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 8,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SearchCard(index: index);
              },
            ))
          ],
        ));
  }
}
