import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as Dotenv;
import 'package:get/get.dart';
import 'package:news_app_one/views/detailpage.dart';
import 'package:news_app_one/views/homepage.dart';

import 'theme/theme.dart';

void main() async {
  await Dotenv.dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
//added something
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
