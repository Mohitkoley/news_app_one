import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_app_one/model/publishers.dart';
import 'package:news_app_one/views/newsbypublishers.dart';

class PublisherPage extends GetWidget {
  Publisherslist publisherslist = Get.put(Publisherslist());

  PublisherPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: GridView.builder(
          padding: const EdgeInsets.all(5),
          physics: const BouncingScrollPhysics(),
          itemCount: publisherslist.publisherlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, childAspectRatio: 1),
          itemBuilder: ((context, index) {
            Publishers publisher = publisherslist.publisherlist[index];
            return GestureDetector(
                onTap: () {
                  Get.to(NewsbyPublishers(
                      domain: publisher.domain,
                      publisherName: publisher.name,
                      publisherImage: publisher.logo));
                },
                child: publisherUi(publisher: publisher));
          })),
    );
  }
}

class publisherUi extends StatelessWidget {
  const publisherUi({
    Key? key,
    required this.publisher,
  }) : super(key: key);

  final Publishers publisher;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shadowColor: Colors.grey,
      color: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: insideCard(publisher: publisher),
    );
  }
}

class insideCard extends StatelessWidget {
  const insideCard({
    Key? key,
    required this.publisher,
  }) : super(key: key);

  final Publishers publisher;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 8,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    publisher.logo,
                  ))),
        ),
        const SizedBox(height: 10),
        Text(publisher.name,
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1!.color))
      ],
    );
  }
}
