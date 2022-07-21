import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:intl/intl.dart';
import 'package:news_app_one/controller/searchnews.dart';
import 'package:news_app_one/model/headline.dart';
import 'package:news_app_one/views/detailpage.dart';
import "dart:ui" as ui;

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchNews search = Get.put(SearchNews());

  @override
  void initState() {
    addSearch();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> newsearch = GlobalKey<FormState>();

  TextEditingController searchcontroller = TextEditingController();

  RxList<Article> articles = RxList<Article>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldkey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: TextFormField(
                controller: searchcontroller,
                style: TextStyle(color: Theme.of(context).primaryColor),
                textDirection: ui.TextDirection.ltr,
                //controller: searchcontroller,
                key: newsearch,
                onChanged: (String value) {
                  setState(() {
                    search.fetchSearch(value);
                  });
                },
                onFieldSubmitted: (value) {
                  search.fetchSearch(value);
                },
                onEditingComplete: () {
                  search.fetchSearch(searchcontroller.text);
                },
                decoration: InputDecoration(
                  suffixIcon: searchcontroller.text.isEmpty
                      ? Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              searchcontroller.clear();
                            });
                          },
                          icon: Icon(
                            Icons.backspace,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.6),
                          )),
                  hintText: "News",
                  hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.caption!.color),
                  contentPadding: const EdgeInsets.all(10),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 10,
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<List<Article>>(
                  initialData: const <Article>[],
                  stream: search.fetchSearch(searchcontroller.text),
                  builder: (context, snapshot) {
                    articles = (snapshot.data ?? <Article>[]).obs;
                    if (snapshot.data == null) {
                      return searchcontroller.text.isEmpty
                          ? Center(
                              child: Text(
                                  "Search by keyword or Publisher or Category",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            )
                          : Center(
                              child: Text(
                                  "Not found any result for ${searchcontroller.text} ",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            );
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

  addSearch() {
    setState(() {
      search.fetchSearch(searchcontroller.text);
    });
  }
}
