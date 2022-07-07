import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app_one/controller/fetchnews.dart';
import 'package:news_app_one/model/headline.dart';
import 'package:news_app_one/views/detailpage.dart';
import "dart:ui" as ui;

class HomePage extends GetWidget<FetchNews> {
  @override
  final controller = Get.put(FetchNews());

  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          key: _scaffoldKey,
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Theme"),
                trailing: Switch(value: light, onChanged: (light) {}),
              );
            },
          )),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('News'),
            backgroundColor: Colors.white,
            centerTitle: true,
            floating: true,
            pinned: false,
            elevation: 0,
            foregroundColor: Colors.blue,
            expandedHeight: 40,
            //leading: Icon(Icons.menu),
          ),
          SliverFillRemaining(
              child: FutureBuilder(
                  future: controller.getNews(),
                  builder: ((context, snapshot) {
                    List<Article> articles = snapshot.data as List<Article>;
                    if (snapshot.hasError) {
                      return Center(
                          child:
                              Text("error is : ${snapshot.error.toString()} "));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          Article article = articles[index];
                          DateFormat dateFormat = DateFormat('dd MMMM yyyy');
                          return Card(
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
                                      style: const TextStyle(
                                          fontSize: 23, color: Colors.black),
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
                                                fontSize: 10,
                                                color: Colors.grey))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })))
        ],
      ),
    );
  }
}
