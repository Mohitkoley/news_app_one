import 'package:get/get.dart';

class Categories {
  String imageUrl;
  String category;

  Categories({required this.imageUrl, required this.category});
}

class CategoriesList extends GetxController {
  List<Categories> categoriesList = [
    Categories(imageUrl: "assets/business.jpg", category: "buisness"),
    Categories(imageUrl: "assets/entertainment.jpg", category: "entertainment"),
    Categories(imageUrl: "assets/health.jpg", category: "health"),
    Categories(imageUrl: "assets/science.jpg", category: "science"),
    Categories(imageUrl: "assets/sports.jpg", category: "sports"),
    Categories(imageUrl: "assets/technology.jpg", category: "technology"),
    Categories(imageUrl: "assets/general.jpg", category: "general"),
  ];
}
