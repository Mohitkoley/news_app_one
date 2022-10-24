import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:news_app_one/theme/theme.dart';
import 'package:news_app_one/views/categoriespage.dart';
import 'package:news_app_one/views/favorite_list.dart';
import 'package:news_app_one/views/home.dart';
import 'package:news_app_one/views/publisherspage.dart';
import 'package:news_app_one/views/search.dart';

class HomePage extends GetWidget {
  HomePage({Key? key}) : super(key: key);

  List pages = [
    Home(),
    Search(),
    CategoriesPage(),
    PublisherPage(),
    const FavoriteList(),
  ];
  RxInt index = 0.obs;
  final GlobalKey<DrawerControllerState> _drawerKey =
      GlobalKey<DrawerControllerState>();
  final themecontroller = Get.put(Sharepref());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() {
          switch (index.value) {
            case 0:
              return Text("News");
            case 1:
              return Text("Search");
            case 2:
              return Text("Categories");
            case 3:
              return Text("Publishers");
            case 4:
              return Text("Favorites");
            default:
              return Text("Headlines");
          }
        }),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      drawer: Drawer(
          backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
          key: _drawerKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return FaIcon(
                    isLightTheme ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
                    color: Theme.of(context).colorScheme.secondary,
                  );
                }),
                ObxValue(
                    (data) => Switch(
                          activeColor: Theme.of(context).colorScheme.secondary,
                          inactiveThumbColor: Colors.grey,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: isLightTheme,
                          onChanged: (data) {
                            setLightTheme(data);
                            Get.changeThemeMode(isLightTheme
                                ? ThemeMode.light
                                : ThemeMode.dark);
                            themecontroller.saveThemeStatus();
                          },
                        ),
                    false.obs)
              ],
            ),
          ])),
      body: Obx(() {
        return pages[index.value];
      }),
      bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeInOut,
          index: 0,
          height: 60,
          backgroundColor: Colors.transparent,
          color: Theme.of(context).primaryColor,
          onTap: (index2) {
            index.value = index2;
          },
          animationDuration: const Duration(milliseconds: 300),
          items: [
            Icon(
              Icons.home,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
            Icon(Icons.search,
                color: Theme.of(context).textTheme.headline1!.color),
            Icon(Icons.category,
                color: Theme.of(context).textTheme.headline1!.color),
            Icon(Icons.group_rounded,
                color: Theme.of(context).textTheme.headline1!.color),
            Icon(Icons.favorite,
                color: Theme.of(context).textTheme.headline1!.color),
          ]),
    );
  }
}
