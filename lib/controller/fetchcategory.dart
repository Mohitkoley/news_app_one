import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_one/model/headline.dart';

class Fetchcategory extends GetxController {
  Fetchcategory() {
    dotenv.load(fileName: ".env");
  }

  fetchcat(String str) async {
    final key = dotenv.env['apikey'];
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=$str&apiKey=$key");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      Headline headline = headlineFromJson(response.body);
      List<Article> articles = headline.articles;
      return articles;
    } else {
      if (response.statusCode == 429) {
        Get.snackbar("Error is: ",
            "Too Many Requests \n This issue will reset in 12 hours");
      }
      throw Exception("Error is: ${response.statusCode}");
    }
  }
}
