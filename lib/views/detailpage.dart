import 'dart:ui' as ui;
import 'package:alan_voice/alan_voice.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_one/model/headline.dart';
import 'package:url_launcher/link.dart';

class DetailPage extends GetWidget {
  Article article;
  DetailPage({Key? key, required this.article}) : super(key: key) {
    AlanVoice.addButton(
        "1ebf4037f8eef3f875173425bbd44f892e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,
        bottomMargin: 20);
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }

  void _handleCommand(Map<String, dynamic> command) {
    debugPrint(command.toString());
    switch (command["command"]) {
      case "back":
        Get.back();
        break;
      default:
        debugPrint("Unknown command: ${command["command"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    String content = article.content!.replaceAll(RegExp(r'...\[.*?]'), ".");
    DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              expandedHeight: 300,
              centerTitle: true,
              stretch: true,
              title: null,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  article.title,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.autourOne(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).appBarTheme.foregroundColor),
                ),
                background: Stack(children: [
                  Container(
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
                  ),
                ]),
              ),
            )
          ];
        }),
        body: Container(
            color: Theme.of(context).backgroundColor,
            width: MediaQuery.of(context).size.width,
            height: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("By ${article.source.name}",
                    style: GoogleFonts.autourOne(
                      shadows: [
                        const Shadow(
                          blurRadius: 10,
                          color: Colors.grey,
                          offset: Offset(5, 5),
                        ),
                      ],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    )),
                const SizedBox(height: 10),
                Flexible(
                  child: Text("$content \nFor more tap below👇",
                      maxLines: 10,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.autourOne(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: 30,
                        letterSpacing: 1.5,
                      )),
                ),
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
                    child: Text(
                        textAlign: TextAlign.end,
                        "published at ${dateFormat.format(article.publishedAt)}",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey))),
              ],
            )),
      ),
    );
  }
}
