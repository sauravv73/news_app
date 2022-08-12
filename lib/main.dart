import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squareboat_assessment/view/news_ui/news_listing.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const GetMaterialApp(home: MyApp(),) );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        backgroundColor: const Color (0xFFF5F9FD),
        primarySwatch: Colors.blue,
      ),
      home: const NewsListing(),
    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
