import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoSearchResult extends StatefulWidget {
  const NoSearchResult({Key? key}) : super(key: key);

  @override
  _NoSearchResultState createState() => _NoSearchResultState();
}

class _NoSearchResultState extends State<NoSearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: const Color(0xFF0C54BE),
          title: const Text(
            "Search",
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: ListView(
          children: const [
            Icon(
              Icons.manage_search,
              size: 100,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  ' No search result',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
