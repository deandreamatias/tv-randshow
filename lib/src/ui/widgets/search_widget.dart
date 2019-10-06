import 'package:flutter/material.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController editingController;
  const SearchWidget({Key key, this.editingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: editingController,
        //autofocus: true,
        decoration: InputDecoration(
          hintText: "Search",
          contentPadding: EdgeInsets.all(0.0),
          //suffixIcon: Icon(Icons.close),
          prefixIcon: Icon(Icons.search, color: StyleColor.SECONDARY),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: StyleColor.SECONDARY),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
        ),
      ),
    );
  }
}
