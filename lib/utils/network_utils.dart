import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:squareboat_assessment/constants/api_constants.dart';
import 'package:squareboat_assessment/model/news_listing_response.dart';

class NetworkUtils {
  // Get news listing
  Future<NewsListingResponse?> getNewsList({
    String? country,
    String? source,
  }) async {
    NewsListingResponse? newsListingResponse;

    try {
      final Uri uri = Uri.parse(ApiConstants.newsListing +
          'country=$country' +
          '&excludeDomains=stackoverflow.com&sortBy=$source&language=en&apiKey=' +
          ApiConstants.apiKey);
      print(uri.toString());
      final http.Response response = await http.get(
        uri,
      );
      if (response.statusCode == 200) {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
        print("News list :" + response.body);
      } else if (response.statusCode == 429) {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
      }else {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
    return newsListingResponse;
  }

  // Search from news listing
  Future<NewsListingResponse?> searchNewsList(
      {String? country, String? source, String? search}) async {
    NewsListingResponse? newsListingResponse;

    try {
      final Uri uri = Uri.parse(ApiConstants.newsListing +
          'country=$country' +
          '&q=$search&excludeDomains=stackoverflow.com&sortBy=$source&language=en&apiKey=' +
          ApiConstants.apiKey);
      print('Search uri : ' + uri.toString());
      final http.Response response = await http.get(
        uri,
      );
      if (response.statusCode == 200) {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
        print("News list :" + response.body);
      } else if (response.statusCode == 429) {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
      } else {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
    return newsListingResponse;
  }

  // Filter news list
  Future<NewsListingResponse?> filterNewsList(
      {String? country, String? source, String? category}) async {
    NewsListingResponse? newsListingResponse;

    try {
      final Uri uri = Uri.parse(ApiConstants.newsListing +
          'country=$country' +
          '&category=$category&excludeDomains=stackoverflow.com&sortBy=$source&language=en&apiKey=' +
          ApiConstants.apiKey);
      print(uri.toString());
      final http.Response response = await http.get(
        uri,
      );
      if (response.statusCode == 200) {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
        print("News list :" + response.body);
      } else if (response.statusCode == 429) {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
      } else {
        newsListingResponse =
            NewsListingResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
    return newsListingResponse;
  }
}
