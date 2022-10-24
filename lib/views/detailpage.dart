import 'dart:ui' as ui;
import 'package:alan_voice/alan_voice.dart';
import "package:flutter/material.dart";
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:news_app_one/model/headline.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailPage extends GetWidget {
  FavLists fav = Get.put(FavLists());
  var isFav = false.obs;
  Article article;
  ScrollController _scrollController = ScrollController();
  double textSize = 25;
  final FlutterTts flutterTts = FlutterTts();
  DetailPage({Key? key, required this.article}) : super(key: key) {
    _scrollController = ScrollController()
      ..addListener(() {
        textSize = _scrollController.offset.toDouble();
      });

    AlanVoice.addButton(
        "1ebf4037f8eef3f875173425bbd44f892e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,
        bottomMargin: 20);
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }

  void _handleCommand(Map<String, dynamic> command) {
    debugPrint(command.toString());
    switch (command["command"]) {
      case "share":
        shareArticle();
        break;
      case "read":
        AlanVoice.deactivate();
        speakArticle(txt: article.content, url: article.url);
        break;
      case "back":
        Get.back();
        break;
      default:
        debugPrint("Unknown command: ${command["command"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    String content = article.content.replaceAll(RegExp(r'...\[.*?]'), ".");
    DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    return Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: ((context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  pinned: false,
                  expandedHeight: 300,
                  stretch: true,
                  title: null,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.50), BlendMode.darken),
                          image: NetworkImage(article.urlToImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(article.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: "Aladin",
                                    fontSize: textSize,
                                    color: Colors.yellowAccent)),
                          ],
                        ),
                      )))
            ];
          }),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        backgroundColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color:
                                Theme.of(context).textTheme.headline1!.color),
                        label: Text(
                          article.source.name,
                        ),
                      ),
                      // IconButton(
                      //   iconSize: 30,
                      //   color: Theme.of(context).primaryColor,
                      //   onPressed: () {
                      //     isFav = !isFav;
                      //     article.copyWith(isFav: isFav);
                      //     if (article.isFav == true) {
                      //       Get.snackbar("Added", "Article to Favorite List",
                      //           backgroundColor: Colors.green,
                      //           snackPosition: SnackPosition.TOP);
                      //       fav.addFav(article);
                      //     } else {
                      //       Get.snackbar(
                      //           "Removed", "Article from Favorite List",
                      //           backgroundColor: Colors.red,
                      //           snackPosition: SnackPosition.TOP);
                      //       fav.removeFav(article);
                      //     }
                      //   },
                      //   icon: Icon(article.isFav
                      //       ? Icons.bookmark_add
                      //       : Icons.bookmark_add_outlined),
                      // ),
                      Obx(() => LiteRollingSwitch(
                            onTap: () {},
                            onChanged: (value) {
                              isFav.value = value;
                              article.copyWith(isFav: isFav.value);
                              if (article.isFav == true) {
                                Get.snackbar(
                                    "Added", "Article to Favorite List",
                                    backgroundColor: Colors.green,
                                    snackPosition: SnackPosition.TOP);
                                fav.addFav(article);
                              } else {
                                Get.snackbar(
                                    "Removed", "Article from Favorite List",
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP);
                                fav.removeFav(article);
                              }
                            },
                            value: isFav.value,
                            textOn: 'Fav',
                            textOff: 'UnFav',
                            colorOff: Colors.grey,
                            colorOn: Colors.blue,
                            iconOff: Icons.bookmark_add_outlined,
                            iconOn: Icons.bookmark_add,
                            onDoubleTap: () {},
                            onSwipe: () {},
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text("$content ",
                    maxLines: 10,
                    // softWrap: true,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.autourOne(
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 25,
                      letterSpacing: 1.5,
                    )),
                Text("For more tap below 👇",
                    style: GoogleFonts.autourOne(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 25,
                      letterSpacing: 1.5,
                    )),
                const SizedBox(height: 15),
                Link(
                    //target: LinkTarget.blank,
                    uri: Uri.parse(article.url),
                    builder: ((context, followLink) => MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                              onTap: followLink,
                              child: Text(
                                article.url,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor,
                                    decoration: TextDecoration.underline),
                              )),
                        ))),
                const SizedBox(height: 15),
                Expanded(
                    child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                      "published at ${dateFormat.format(article.publishedAt)}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                )),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          focusElevation: 5,
          hoverElevation: 15,
          tooltip: "Share This article",
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          onPressed: shareArticle,
          child: const Icon(Icons.share),
        ));
  }

  shareArticle() {
    Share.share(
      "Check out this article \nShared by NewsApp \n ${article.url}",
    );
  }

  speakArticle({required String txt, required String url}) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);

    if (txt == "No Author") {
      flutterTts.speak("No content to read redirecting to source");
      await Future.delayed(Duration(seconds: 1));
      launchUrlString(url);
    }
    await flutterTts.speak(txt);
    AlanVoice.activate();
  }
}
