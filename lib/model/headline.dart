// To parse this JSON data, do
//
//     final headline = headlineFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Headline headlineFromJson(String str) => Headline.fromJson(json.decode(str));

String headlineToJson(Headline data) => json.encode(data.toJson());

class Headline {
  Headline({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory Headline.fromJson(Map<String, dynamic> json) => Headline(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? "No Author",
        title: json["title"],
        description: json["description"] ?? "No Description",
        url: json["url"],
        urlToImage: json["urlToImage"] ??
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019",
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? "No Content",
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  Source({
    this.id,
    required this.name,
  });

  String? id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] ?? "No Id",
        name: json["name"] ?? "No Name",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "name": name,
      };
}
