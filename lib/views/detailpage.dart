import 'dart:ui';

import "package:flutter/material.dart";
import 'package:get/get.dart';

import 'package:news_app_one/model/headline.dart';

class DetailPage extends GetWidget {
  Article article;
  DetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  opacity: 9.0,
                  image: NetworkImage(article.urlToImage),
                  fit: BoxFit.fitWidth)),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    "${article.description}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  )))),
    );
  }
}
