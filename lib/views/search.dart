import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:intl/intl.dart';
import 'package:news_app_one/controller/searchnews.dart';
import 'package:news_app_one/model/headline.dart';
import 'package:news_app_one/views/detailpage.dart';
import "dart:ui" as ui;

class Search extends GetWidget {
  SearchNews search = Get.put(SearchNews());
  Search({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> newsearch = GlobalKey<FormState>();
  TextEditingController searchcontroller = TextEditingController();
  String searchText = '';
  RxList<Article> articles = RxList<Article>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldkey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              textDirection: ui.TextDirection.ltr,
              controller: searchcontroller,
              key: newsearch,
              onChanged: (value) {
                search.fetchSearch(value);
              },
              onFieldSubmitted: (value) {
                search.fetchSearch(value);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a search term";
                }
                return null;
              },
              onEditingComplete: () {
                search.fetchSearch(searchcontroller.text);
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: search.fetchSearch(searchText),
                  builder: (context, snapshot) {
                    articles =
                        ((snapshot.data ?? <Article>[]) as List<Article>).obs;
                    if (snapshot.data == null) {
                      return Text("Search Anything",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor));
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    }
                    return ListView.builder(
                      key: const PageStorageKey<String>("News"),
                      //controller: ScrollController(),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                      },
                    );
                  }),
            ),
          ],
        ));
  }
}
