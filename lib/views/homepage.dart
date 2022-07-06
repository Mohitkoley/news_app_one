import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_one/controller/fetchnews.dart';
import 'package:news_app_one/model/headline.dart';
import 'package:news_app_one/views/detailpage.dart';

class HomePage extends GetWidget<FetchNews> {
  @override
  final controller = Get.put(FetchNews());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('News'),
            //expandedHeight: 200,
            backgroundColor: Colors.blue,
            centerTitle: true,
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      article.urlToImage,
                                      height: 300,
                                      width: 270,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      article.title,
                                      textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
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
