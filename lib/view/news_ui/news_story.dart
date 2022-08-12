import 'dart:async';
import 'package:flutter/material.dart';
import 'package:squareboat_assessment/utils/common_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NewsStory extends StatefulWidget {
  const NewsStory({Key? key, this.url}) : super(key: key);
  final String? url;
  @override
  _NewsStoryState createState() =>
      _NewsStoryState();
}

class _NewsStoryState extends State<NewsStory> {

  double progress = 0;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  String body = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? url = widget.url;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          // decoration: BoxDecoration(gradient: Constants().linearGradient),
        ),
        leadingWidth: 80,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const[
              SizedBox(width: 10,),
              Icon(Icons.arrow_back_ios,color: Colors.white,),
              Text('Back',style: TextStyle(color: Colors.white,fontSize: 18.0,),)
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
            // progress > 90 ? isLoading = false : isLoading;
            setState(() {

            });
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            CommonUtils.showDialogProgress(context);
          },

          onPageFinished: (_){
            CommonUtils.dismissDialogProgress();
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
          // isLoading ? Center(
          //   child: CommonUtils().progressBar() ,
          // ) : Container()
        ]
      ),);
  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}