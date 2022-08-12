import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:squareboat_assessment/controller/news_controller.dart';
import 'package:squareboat_assessment/utils/common_utils.dart';

import 'news_story.dart';


class NewsDetails extends StatefulWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? author;
  final String? publishedAt;
  final String? url;
  const NewsDetails(
      {Key? key,
      this.title,
      this.description,
      this.imageUrl,
      this.author,
      this.publishedAt,
      this.url})
      : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: 250,
            child: CachedNetworkImage(
              width: 10,
              height: 100,
              fit: BoxFit.cover,
              imageUrl: widget.imageUrl ??
                  'http://chamseddinprod.n1.iworklab.com/images/restaurant_image/rest1.jpeg',
              placeholder: (context, url) => CommonUtils().progressBar(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            color: const Color(0xFFF5F9FD),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                widget.title.toString(),
                style: const TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 100,
            color: const Color(0xFFF5F9FD),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                widget.author.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
          Container(
            width: 100,
            color: const Color(0xFFF5F9FD),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                widget.publishedAt!.substring(0, 10) +
                    ' at ' +
                    widget.publishedAt!.substring(11, 16),
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            color: const Color(0xFFF5F9FD),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                widget.description.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          Container(
            color: const Color(0xFFF5F9FD),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 0, bottom: 20),
              child: InkWell(
                onTap: () {
                  Get.to(() => NewsStory(url: widget.url.toString()));
                  setState(() {});
                },
                child: Row(
                  children: const [
                    Text(
                      'See full story',
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.lightBlue,
                      size: 13,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
