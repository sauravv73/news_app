import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squareboat_assessment/controller/news_controller.dart';

class CategoryModalSheet extends StatefulWidget {
  const CategoryModalSheet({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryModalSheetState createState() => _CategoryModalSheetState();
}

class _CategoryModalSheetState extends State<CategoryModalSheet> {
  final NewsController newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const Padding(
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 0),
        child: Text(
          'Filter by Category',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const Divider(),
      ListTile(
        title: const Text(
          'Business',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        trailing: Radio<String>(
          value: newsController.business.value,
          onChanged: (value) {
            setState(() {
              newsController.selectedCategory.value = value.toString();
            });
          },
          groupValue: newsController.selectedCategory.value,
        ),
      ),
      ListTile(
        title: const Text(
          'Entertainment',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        trailing: Radio<String>(
          value: newsController.entertainment.value,
          onChanged: (value) {
            setState(() {
              newsController.selectedCategory.value = value!;
            });
          },
          groupValue: newsController.selectedCategory.value,
        ),
      ),
      ListTile(
        title: const Text(
          'General',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        trailing: Radio<String>(
          value: newsController.general.value,
          onChanged: (value) {
            setState(() {
              newsController.selectedCategory.value = value!;
            });
          },
          groupValue: newsController.selectedCategory.value,
        ),
      ),
      ListTile(
        title: const Text(
          'Health',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        trailing: Radio<String>(
          value: newsController.health.value,
          onChanged: (value) {
            setState(() {
              newsController.selectedCategory.value = value!;
            });
          },
          groupValue: newsController.selectedCategory.value,
        ),
      ),
      ListTile(
        title: const Text(
          'Science',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        trailing: Radio<String>(
          value: newsController.science.value,
          onChanged: (value) {
            setState(() {
              newsController.selectedCategory.value = value!;
            });
          },
          groupValue: newsController.selectedCategory.value,
        ),
      ),
      ListTile(
        title: const Text(
          'Sports',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        trailing: Radio<String>(
          value: newsController.sports.value,
          onChanged: (value) {
            setState(() {
              newsController.selectedCategory.value = value!;
            });
          },
          groupValue: newsController.selectedCategory.value,
        ),
      ),
      ListTile(
        title: const Text(
          'Technology',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        trailing: Radio<String>(
          value: newsController.technology.value,
          onChanged: (value) {
            setState(() {
              newsController.selectedCategory.value = value!;
            });
          },
          groupValue: newsController.selectedCategory.value,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0, right: 60, left: 60),
        child: ElevatedButton(
            onPressed: () async {
              await newsController.newsListingFilterCategory(
                  country: newsController.selectedCountry.value,
                  source: newsController.selectedSortBy.value,
                  category: newsController.selectedCategory.value,
              context: context);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text(
              'Apply Filter',
            )),
      )
    ]);
  }
}
