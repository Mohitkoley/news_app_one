import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as Dotenv;
import 'package:get/get.dart';
import 'package:news_app_one/views/homepage.dart';

void main() async {
  await Dotenv.dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
