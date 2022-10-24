import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app_one/model/headline.dart';
import "dart:ui" as ui;

import 'package:news_app_one/views/detailpage.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<Article> _articles = <Article>[];
  FavLists fav = Get.put(FavLists());

  @override
  void initState() {
    super.initState();
    getLists();
    removeList();
  }

  getLists() {
    _articles = fav.favList.toList();
  }

  removeList() {
    fav.favList.removeWhere((element) => element.isFav == false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).backgroundColor,
      child: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          Article article = _articles[index];
          DateFormat dateFormat = DateFormat('dd MMMM yyyy');
          if (_articles.isEmpty) {
            return Center(
                child: Text("No News Added ",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color)));
          } else {
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
                            color:
                                Theme.of(context).textTheme.headline1!.color),
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
          }
        },
      ),
    ));
  }
}
