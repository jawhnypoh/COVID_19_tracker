// API Resources methods

import 'package:covid_19_tracker/models/global_model.dart';
import 'package:covid_19_tracker/models/timeline_date_model.dart';
import 'package:covid_19_tracker/models/news_article_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ApiResources {
  final String _globalURL = 'https://disease.sh/v2/all';
  final String _countriesURL = 'https://disease.sh/v2/countries';
  final String _statesURL = "https://disease.sh/v2/states";
  final String _historicalTimelineURL = 'https://corona-api.com/timeline';
  final String _newsArticlesURL = 'https://api.smartable.ai/coronavirus/news/US';

  var dio = Dio();

  // Get results from disease.sh API for worldwide
  Future<GlobalStats> getGlobalResult() async {
    try {
      final Response response = await dio.get(_globalURL);
      final jsonResult = json.decode(response.toString());

      return GlobalStats.fromJson(jsonResult);
    } catch (e) {
      print(e);
    }
  }

  // Get results from corona-api API for timeline
  Future<List<TimelineDateModel>> getTimelineResults() async {
    try {
      final Response response = await dio.get(_historicalTimelineURL);
      final jsonResult = json.decode(response.toString());
      final timelineList = jsonResult['data'] as List;

      return timelineList.map<TimelineDateModel>((json) => TimelineDateModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Get results from api.smartable.ai API for news
  Future<List<NewsArticleModel>> getNewsArticleResults() async {
    String subscriptionKey = '3009d4ccc29e4808af1ccc25c69b4d5d';
    List<NewsArticleModel> newsArticlesList;

    dio.options.headers = {'Subscription-Key' : subscriptionKey};
    try {
      final Response response = await dio.get(_newsArticlesURL);
      final jsonResult = json.decode(response.toString());
      final newsArticlesFromJSON = jsonResult['news'] as List;
      newsArticlesList = newsArticlesFromJSON.map<NewsArticleModel>((json) =>
          NewsArticleModel.fromJson(json)).toList();

      return newsArticlesList;
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Get results from disease.sh API for all countries
  Future<List> getCountryResults() async {
    final List resultsList = List();

    try {
      final Response response = await dio.get(_countriesURL);
      for(int i = 0; i <response.data.length; i++) {
        resultsList.add(response.data[i]);
      }
      resultsList.sort((b, a) => a['cases'].compareTo(b['cases']));
      return resultsList;
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Get results from disease.sh API for all US states
  Future<List> getUSResults() async {
    final List resultsList = List();

    try {
      final Response response = await dio.get(_statesURL);
      for(int i = 0; i < response.data.length; i++) {
        resultsList.add(response.data[i]);
      }
      resultsList.sort((b, a) => a['cases'].compareTo(b['cases']));

      return resultsList;
    } catch (e) {
      print(e);
    }
  }
}