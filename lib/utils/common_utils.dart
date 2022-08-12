
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonUtils {

  // Check if network connection is available or not
  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }


  // Display circular progress indicator
  Widget progressBar() {
    return const SizedBox(
      height : 50,
      width : 80,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  static void showDialogProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future<bool> _onWillPop() {
          return Future.value(true);
        }
        return WillPopScope(
          onWillPop: _onWillPop,
          child: const Center(
            child: CupertinoActivityIndicator(radius: 22),
          ),
        );
      },
    );
  }

  static void dismissDialogProgress() {

      Get.back();

  }

}