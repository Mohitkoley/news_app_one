import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightTheme = ThemeData().copyWith(
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
  backgroundColor: Colors.white,
  colorScheme: ThemeData().colorScheme.copyWith(
        secondary: Colors.blue,
      ),
  cardColor: Colors.white,
  textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.black),
      caption: TextStyle(color: Colors.grey)),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white, foregroundColor: Colors.blue),
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.green,
    disabledColor: Colors.grey,
  ),
);

ThemeData darkTheme = ThemeData().copyWith(
  
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
  backgroundColor: Colors.black,
  colorScheme: ThemeData().colorScheme.copyWith(
        secondary: Colors.purple,
      ),
  cardColor: const Color.fromARGB(255, 31, 29, 29),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black, foregroundColor: Colors.purple),
  textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.grey)),
  brightness: Brightness.dark,
  primaryColor: Colors.purpleAccent,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.purpleAccent,
    disabledColor: Colors.grey,
  ),
);

RxBool _isLightTheme = false.obs;

get isLightTheme => _isLightTheme.value;

setLightTheme(bool value) => _isLightTheme.value = value;

class Sharepref extends GetxController {
  static final sharedpref = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await sharedpref;
    pref.setBool('isLightTheme', isLightTheme);
  }

  getThemeStatus() async {
    var isLight = sharedpref
        .then(
            (SharedPreferences prefs) => prefs.getBool('isLightTheme') ?? true)
        .obs;
    setLightTheme(await isLight.value);
    Get.changeThemeMode(isLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  Sharepref() {
    getThemeStatus();
  }
}
