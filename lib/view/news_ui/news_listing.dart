import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:squareboat_assessment/controller/news_controller.dart';
import 'package:squareboat_assessment/model/news_listing_response.dart';
import 'package:squareboat_assessment/utils/common_utils.dart';
import 'package:squareboat_assessment/view/modal_sheet/category_modal_bottom_sheet.dart';
import 'package:squareboat_assessment/view/modal_sheet/country_modal_bottom_sheet.dart';
import '../no_internet_connection.dart';
import 'news_details.dart';

class NewsListing extends StatefulWidget {
  const NewsListing({Key? key}) : super(key: key);

  @override
  _NewsListingState createState() => _NewsListingState();
}

class _NewsListingState extends State<NewsListing> {
  final NewsController newsController = Get.put(NewsController());


  @override
  void initState() {
    super.initState();
    CommonUtils.isNetworkAvailable().then((value) async {
      if (value) {
        newsController.newsListing(
            country: newsController.selectedCountry.value,
            source: newsController.selectedSortBy.value,
            context: context);
      } else {
        Get.to(() => const NoInternetAvailable());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    newsController.searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          backgroundColor: const Color(0xFF0C54BE),
          title: const Text(
            "My News",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                _showBottomLocationSheet();
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
                                    : newsController.selectedCountry.value ==
                                            'pi'
                                        ? const Text('Pacific Island')
                                        : newsController
                                                    .selectedCountry.value ==
                                                'sl'
                                            ? const Text('Sri Lanka')
                                            : newsController.selectedCountry
                                                        .value ==
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  8,
                ),
                child: TextField(
                  controller: newsController.searchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      fillColor: const Color(0xFFCED3DC),
                      filled: true,
                      hintText: ' Search for news, topics...',
                      hintStyle: const TextStyle(
                          color: Color(0xFFA6A6A6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: .0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 1.0),
                      ),
                      suffixIcon: const Icon(Icons.search)),
                  onChanged: (var count) async {
                    if (newsController.searchController.text.length > 3) {
                      await newsController.newsListingSearch(
                          country: newsController.selectedCountry.value,
                          source: newsController.selectedSortBy.value,
                          search: newsController.searchController.text,
                          context: context);
                    } else if (newsController.searchController.text.isEmpty) {
                      await newsController.newsListingSearch(
                          country: newsController.selectedCountry.value,
                          source: newsController.selectedSortBy.value,
                          search: newsController.searchController.text,
                          context: context);
                    }
                  },
                  onEditingComplete: () async {
                    await newsController.newsListingSearch(
                        country: newsController.selectedCountry.value,
                        source: newsController.selectedSortBy.value,
                        search: newsController.searchController.text,
                        context: context);
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    const Text(
                      'Top Headlines',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Text('Sort : '),
                    Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value: newsController.selectedValue.value,
                                style: const TextStyle(color: Colors.black),
                                items: <String>[
                                  'Newest',
                                  'Popular',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    newsController.selectedValue.value =
                                        newValue.toString();
                                    newsController.selectedValue.value ==
                                            'Newest'
                                        ? newsController.newsListing(
                                            country: newsController
                                                .selectedCountry.value,
                                            source:
                                                newsController.publishing.value,
                                            context: context)
                                        : newsController.newsListing(
                                            country: newsController
                                                .selectedCountry.value,
                                            source:
                                                newsController.popularity.value,
                                            context: context);
                                  });
                                })))
                  ],
                ),
              ),
              // newsController.isLoading.value == true ? CommonUtils().progressBar() :
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsController.articles.length,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, index) {
                    return createList(newsController.articles[index]);
                  },
                ),
              )
            ],
          ),
        )));
  }

  createList(Articles articles) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(() => NewsDetails(
                imageUrl: articles.urlToImage.toString(),
                title: articles.title,
                description: articles.description,
                author: articles.author,
                publishedAt: articles.publishedAt,
                url: articles.url,
              ));
        },
        child: SingleChildScrollView(
          child: Container(
              width: 300,
              height: 130,
              margin:
                  const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5)),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            articles.source!.name.toString(),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF303F60),
                                fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              articles.description.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCED3DC),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CachedNetworkImage(
                              width: 10,
                              height: 100,
                              fit: BoxFit.cover,
                              imageUrl: articles.urlToImage == null
                                  ? 'http://chamseddinprod.n1.iworklab.com/images/restaurant_image/rest1.jpeg'
                                  : articles.urlToImage.toString(),
                              placeholder: (context, url) =>
                                  CommonUtils().progressBar(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ))),
                ],
              )),
        ),
      ),
    );
  }

  // Bottom sheet to select country
  _showBottomLocationSheet() async {
    showModalBottomSheet<dynamic>(
        context: context,
        builder: (BuildContext bc) {
          return const CountryModalSheet();
        });
  }

  // filter button
  floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // filterByPublish();
        filterByCategory();
        setState(() {});
      },
      backgroundColor: Colors.blueAccent,
      child: const Icon(
        Icons.filter_alt_outlined,
        color: Colors.white,
      ),
    );
  }

  // Category filter bottom sheet
  filterByCategory() {
    showModalBottomSheet<dynamic>(
        context: context,
        builder: (BuildContext bc) {
          return const CategoryModalSheet();
        });
  }
}
