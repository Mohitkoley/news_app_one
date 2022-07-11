import 'package:flutter/material.dart';
import "package:get/get.dart";

class Search extends GetWidget {
  Search({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Center(child: Text("Search", style: TextStyle(color: Colors.red))),
    );
  }
}
