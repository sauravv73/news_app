import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squareboat_assessment/controller/news_controller.dart';

import 'news_ui/news_listing.dart';

class NoInternetAvailable extends StatefulWidget {
  const NoInternetAvailable({Key? key}) : super(key: key);

  @override
  _NoInternetAvailableState createState() => _NoInternetAvailableState();
}

class _NoInternetAvailableState extends State<NoInternetAvailable> {
  final NewsController newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C54BE),
        title: const Text(
          "My News",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // _showBottomLocationSheet();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text('Location'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 15),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      newsController.selectedCountry.value == 'in'
                          ? const Text('India')
                          : newsController.selectedCountry.value == 'ne'
                              ? const Text('Nepal')
                              : newsController.selectedCountry.value == 'us'
                                  ? const Text('USA')
                                  : newsController.selectedCountry.value == 'pi'
                                      ? const Text('Pacific Island')
                                      : newsController.selectedCountry.value ==
                                              'sl'
                                          ? const Text('Sri Lanka')
                                          : newsController
                                                      .selectedCountry.value ==
                                                  'gb'
                                              ? const Text('England')
                                              : const Text('Sweden'),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 100,
            ),
            child: Icon(
              Icons.network_check_outlined,
              size: 40,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
                child: Text(
              'No Internet connection!',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 60, left: 60),
            child: ElevatedButton(
                onPressed: () async {
                  Get.to(() => const NewsListing());
                },
                child: const Text(
                  'Try Again',
                )),
          )
        ],
      ),
    );
  }
}
