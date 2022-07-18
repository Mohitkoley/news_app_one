import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app_one/controller/fetchcategory.dart';
import 'package:news_app_one/model/headline.dart';
import "dart:ui" as ui;

import 'package:news_app_one/views/detailpage.dart';

class newsbycategory extends GetWidget<Fetchcategory> {
  Fetchcategory fetchcategory = Get.put(Fetchcategory());
  String categorystring;
  String appbarimage;
  newsbycategory(
      {Key? key, required this.categorystring, required this.appbarimage})
      : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: fetchcategory.fetchcat(categorystring),
        builder: ((context, snapshot) {
          List<Article> articles =
              (snapshot.data ?? <Article>[]) as List<Article>;
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}",
                  style: const TextStyle(color: Colors.red)),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                key: const PageStorageKey<String>("category"),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  Article article = articles[index];
                  DateFormat dateFormat = DateFormat('dd MMMM yyyy');
                  return Card(
                    shadowColor: Colors.grey,
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(DetailPage(article: article));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.network(
                              article.urlToImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              textAlign: TextAlign.start,
                              maxLines: 4,
                              article.title,
                              textDirection: ui.TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    " Published at ${dateFormat.format(article.publishedAt)} ",
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
