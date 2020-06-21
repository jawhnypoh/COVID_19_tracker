// API Resources methods

import 'package:covid_19_tracker/models/country_model.dart';
import 'package:covid_19_tracker/models/global_model.dart';
import 'package:covid_19_tracker/models/news_article_model.dart';
import 'package:covid_19_tracker/models/us_county_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ApiResources {
  final String _globalURL = 'https://disease.sh/v2/all';
  final String _countriesURL = 'https://disease.sh/v2/countries';
  final String _singleCountryURL = 'https://corona-api.com/countries/';
  final String _globalHistoricalTimelineURL = 'https://corona-api.com/timeline';
  final String _stateHistoricalTimelineURL = 'https://covidtracking.com/api/v1/states/';
  final String _newsArticlesURL = 'https://www.reddit.com/r/Coronavirus.json?limit=100';
  final String _usCountiesURL = "https://covid19-us-api.herokuapp.com/county";

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

  // Get results from corona-api API for global timeline
  Future<List> getGlobalHistoricalDataResults() async {
    final List resultsList = List();

    try {
      final Response response = await dio.get(_globalHistoricalTimelineURL);
      for(int i = 0; i < response.data['data'].length; i++) {
        resultsList.add(response.data['data'][i]);
      }
      return resultsList;
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Get results from covidtracking.com API for state timeline
  Future<List> getStateHistoricalDataResults(String stateName) async {
    final List resultsList = List();

    try {
      final Response response = await dio.get(_stateHistoricalTimelineURL + stateName.toLowerCase() + '/daily.json');
      for(int i = 0; i < response.data.length; i++) {
        resultsList.add(response.data[i]);
      }
      return resultsList;
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Get results from api.smartable.ai API for news
  Future<List<NewsArticleModel>> getNewsArticleResults() async {
    List<NewsArticleModel> newsArticlesList;
    List newsArticlesFromReddit = List();

    try {
      final Response response = await dio.get(_newsArticlesURL);
      final jsonResult = json.decode(response.toString());

      for (int i = 2; i < response.data['data']['children'].length; i++) {
        newsArticlesFromReddit.add(response.data['data']['children'][i]);
      }

      newsArticlesList = newsArticlesFromReddit.map<NewsArticleModel>((json) =>
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

  // Get results from corona-api for a single country
  Future<CountryStats> getSingleCountryResults(String countryCode) async {
    try {
      final Response response = await dio.get(_singleCountryURL + countryCode);
      final jsonResult = json.decode(response.toString());

      return CountryStats.fromJson(jsonResult);
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Get results from covid19-us-api for all US counties
  Future<List<USCountyStats>> getUSCountiesResults(String stateName) async {
    final List<USCountyStats> resultsList = List();
    List<USCountyStats> filteredResultsList = List();

    try {
      final Response response = await dio.get(_usCountiesURL);
      for(int i = 0; i <response.data.length; i++) {
        resultsList.add(USCountyStats.fromJson(response.data['message'][i]));
      }

      filteredResultsList = resultsList.where((county) => county.stateName == stateName).toList();
      return filteredResultsList;
    } catch (e) {
      print(e);
      return e;
    }
  }
}