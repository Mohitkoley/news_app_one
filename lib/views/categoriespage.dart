import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:news_app_one/model/categories.dart";
import 'package:news_app_one/views/newsbycategory.dart';

class CategoriesPage extends GetWidget {
  CategoriesList categoriesList = Get.put(CategoriesList());
  CategoriesPage({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldkey,
      body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemCount: categoriesList.categoriesList.length,
              itemBuilder: (context, index) {
                Categories category = categoriesList.categoriesList[index];
                return SingleChildScrollView(
                  child: GestureDetector(
                      onTap: () => Get.to(newsbycategory(
                            categorystring: category.category,
                            appbarimage: category.imageUrl,
                          )),
                      child: listUi(context, category)),
                );
              })),
    );
  }

  Widget listUi(BuildContext context, Categories category) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(category.imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.40), BlendMode.darken),
              )),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(category.category,
                    style: const TextStyle(
                        letterSpacing: 5,
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Aladin",
                        fontWeight: FontWeight.bold))
              ],
            ),
          )),
    );
  }
}
