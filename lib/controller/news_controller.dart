import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:squareboat_assessment/model/news_listing_response.dart';
import 'package:squareboat_assessment/utils/common_utils.dart';
import 'package:squareboat_assessment/utils/network_utils.dart';
import 'package:squareboat_assessment/view/no_search_result.dart';


class NewsController extends GetxController {
  NetworkUtils networkUtil = NetworkUtils();
  RxList<Articles> articles = <Articles>[].obs;
  RxList<Articles> articleData = <Articles>[].obs;
  RxString selectedCountry = 'in'.obs;
  RxString nepal = 'ne'.obs;
  RxString usa = 'us'.obs;
  RxString india = 'in'.obs;
  RxString sriLanka = 'lk'.obs;
  RxString england = 'gb'.obs;
  RxString sweden = 'sr'.obs;
  RxString pacificIsland = 'pi'.obs;
  final TextEditingController searchController = TextEditingController();
  RxBool isLoading = true.obs;
  RxInt count = 0.obs;

  RxString selectedSortBy = 'publishedAt'.obs;
  RxString publishing = 'publishedAt'.obs;
  RxString popularity = 'popularity'.obs;

  RxString selectedCategory = 'general'.obs;
  RxString business = 'business'.obs;
  RxString entertainment = 'entertainment'.obs;
  RxString general = 'general'.obs;
  RxString health = 'health'.obs;
  RxString science = 'science'.obs;
  RxString sports = 'sports'.obs;
  RxString technology = 'technology'.obs;
  RxString selectedValue = 'Newest'.obs;

  // News listing
  newsListing({String? country, String? source, BuildContext? context}) async {
    CommonUtils.showDialogProgress(context!);
    await networkUtil
        .getNewsList(country: country, source: source)
        .then((response) {
      if (response != null) {
        CommonUtils.dismissDialogProgress();
        if (response.status == "ok") {
          articles.value = response.articles!;
          articleData.addAll(response.articles!);
          count.value = response.totalResults!;
        } else if(response.status == 'error') {
          CommonUtils.dismissDialogProgress();
          Get.snackbar(response.status.toString(), "Something went wrong");
        } else {
          CommonUtils.dismissDialogProgress();
          Get.snackbar(response.status.toString(), "Something went wrong");
        }
      }
    });
  }

  // Search
  newsListingSearch({String? country, String? source, String? search, BuildContext? context}) async {
    CommonUtils.showDialogProgress(context!);
    await networkUtil
        .searchNewsList(country: country, source: source, search: search)
        .then((response) {
      if (response != null) {
        CommonUtils.dismissDialogProgress();
        if (response.status == "ok" && response.totalResults != 0) {
          articles.value = response.articles!;
          articleData.addAll(response.articles!);
          isLoading.value = false;
          count.value = response.totalResults!;
        } else if (response.status == 'ok' && response.totalResults == 0) {
          CommonUtils.dismissDialogProgress();
          Get.to(() => const NoSearchResult());
        } else {
          CommonUtils.dismissDialogProgress();
          Get.snackbar(response.status.toString(), "Something went wrong");
        }
      }
    });
  }

  // Filter data using category
  newsListingFilterCategory(
      {String? country, String? source, String? category, BuildContext? context}) async {
    CommonUtils.showDialogProgress(context!);
    await networkUtil
        .filterNewsList(country: country, source: source, category: category)
        .then((response) {
      if (response != null) {
        CommonUtils.dismissDialogProgress();
        if (response.status == "ok") {
          articles.value = response.articles!;
          articleData.addAll(response.articles!);
          isLoading.value = false;
          count.value = response.totalResults!;
        } else if(response.status == 'error') {
          CommonUtils.dismissDialogProgress();
          Get.snackbar(response.status.toString(), "Something went wrong");
        } else {
          CommonUtils.dismissDialogProgress();
          Get.snackbar(response.status.toString(), "Something went wrong");
        }
      }
    });
  }
}
