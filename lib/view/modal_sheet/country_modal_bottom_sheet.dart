import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squareboat_assessment/controller/news_controller.dart';

class CountryModalSheet extends StatefulWidget {

  const CountryModalSheet({Key? key,}) : super(key: key);


  @override
  _CountryModalSheetState createState() => _CountryModalSheetState();
}

class _CountryModalSheetState extends State<CountryModalSheet>{

  final NewsController newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 0, left: 20),
            child: Text('Choose your location', style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
          ),
          const Divider(),
          ListTile(
            title: const Text('Nepal'),
            trailing: Radio<String>(
              value: newsController.nepal.value,
              onChanged: (value) {
                setState(() {
                  newsController.selectedCountry.value = value.toString();
                });
              }, groupValue: newsController.selectedCountry.value,
            ),
          ),
          ListTile(
            title: const Text('USA'),
            trailing: Radio<String>(
              value: newsController.usa.value,
              onChanged: (value) {
                setState(() {
                  newsController.selectedCountry.value = value!;
                });
              }, groupValue: newsController.selectedCountry.value,
            ),
          ),
          ListTile(
            title: const Text('India'),
            trailing: Radio<String>(
              value: newsController.india.value,
              onChanged: (value) {
                setState(() {
                  newsController.selectedCountry.value = value!;
                });
              }, groupValue: newsController.selectedCountry.value,
            ),
          ),
          ListTile(
            title: const Text('Sri Lanka'),
            trailing: Radio<String>(
              value: newsController.sriLanka.value,
              onChanged: (value) {
                setState(() {
                  newsController.selectedCountry.value = value!;
                });
              }, groupValue: newsController.selectedCountry.value,
            ),
          ),
          ListTile(
            title: const Text('England'),
            trailing: Radio<String>(
              value: newsController.england.value,
              onChanged: (value) {
                setState(() {
                  newsController.selectedCountry.value = value!;
                });
              }, groupValue: newsController.selectedCountry.value,
            ),
          ),
          ListTile(
            title: const Text('Sweden'),
            trailing: Radio<String>(
              value: newsController.sweden.value,
              onChanged: (value) {
                setState(() {
                  newsController.selectedCountry.value = value!;
                });
              }, groupValue: newsController.selectedCountry.value,
            ),
          ),
          ListTile(
            title: const Text('Pacific Islands'),
            trailing: Radio<String>(
              value: newsController.pacificIsland.value,
              onChanged: (value) {
                setState(() {
                  newsController.selectedCountry.value= value!;
                });
              }, groupValue: newsController.selectedCountry.value,
            ),
          ),
          Padding(padding: const EdgeInsets.only(
              top: 0, right: 60, left: 60
          ),
            child: ElevatedButton(onPressed: () async {
              await newsController.newsListing(country: newsController.selectedCountry.value, context: context);
              Navigator.of(context).pop();
              setState(() {

              });
            }, child:  const Text('Apply', ) ),

          )
        ]
    );
  }

}

