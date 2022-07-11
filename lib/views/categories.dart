import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends GetWidget {
  Categories({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Center(
          child: Text("Categories", style: TextStyle(color: Colors.red))),
    );
  }
}
