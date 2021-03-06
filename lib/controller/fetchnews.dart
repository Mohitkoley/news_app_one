import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:get/get.dart";
import "package:http/http.dart" as http;
import 'package:news_app_one/model/headline.dart';

class FetchNews extends GetxController {
  String? key = dotenv.env['apikey'];

  getNews() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=$key");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      //debugPrint("Response:  ${response.body}");
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
