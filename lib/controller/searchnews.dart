import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:news_app_one/model/headline.dart';

class SearchNews extends GetxController {
  var apikey = dotenv.env['apikey'];

  fetchSearch(String search2) async* {
    String url = "https://newsapi.org/v2/everything?q=$search2&apiKey=$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Headline headline = headlineFromJson(response.body);
      yield headline.articles;
    } else {
      throw Exception("Error is: ${response.statusCode}");
    }
  }

  Search() {
    dotenv.load(fileName: ".env");
  }
}