// API Resources methods

import 'package:covid_19_tracker/models/country_model.dart';
import 'package:covid_19_tracker/models/global_model.dart';
import 'package:covid_19_tracker/models/news_article_model.dart';
import 'package:covid_19_tracker/models/state_historical_data_model.dart';
import 'package:covid_19_tracker/models/state_model.dart';
import 'package:covid_19_tracker/models/testing_center_model.dart';
import 'package:covid_19_tracker/models/us_county_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ApiResources {
  final String _globalURL = 'https://disease.sh/v2/all';
  final String _countriesURL = 'https://disease.sh/v2/countries';
  final String _singleCountryURL = 'https://corona-api.com/countries/';
  final String _singleStateURL = 'https://api.covidactnow.org/v2/state/';
  final String _singleStateHistoricalURL = 'https://covidtracking.com/api/v1/states/';
  final String _globalHistoricalTimelineURL = 'https://corona-api.com/timeline';
  final String _stateHistoricalTimelineURL = 'https://covidtracking.com/api/v1/states/';
  final String _newsArticlesURL = 'https://www.reddit.com/r/Coronavirus.json?limit=100';
  final String _usCountiesURL = 'https://covid19-us-api.herokuapp.com/county';
  final String _usTestingCentersURL = 'https://sheetlabs.com/NCOR/covidtestcentersinUS?state=';

  final String apiKey = 'c3cc1912d5ae41d88782d801c5abf346';

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

  // Get results from r/Coronavirus subreddit API for news
  Future<List<NewsArticleModel>> getNewsArticleResults() async {
    List<NewsArticleModel> newsArticlesList;
    List newsArticlesFromReddit = List();

    try {
      final Response response = await dio.get(_newsArticlesURL);

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

  // Get results from covidtracking for single US state
  Future<StateStats> getSingleStateResults(String state) async {
    try {
      final Response response = await dio.get(_singleStateURL + state.toUpperCase() + '.json?apiKey=' + apiKey);
      final jsonResult = json.decode(response.toString());

      return StateStats.fromJson(jsonResult);
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Get historical results from covidtracking for single US state by date
  Future<StateHistoricalStats> getSingleStateHistoricalResults(String state, String date) async {
    try {
      print(_singleStateHistoricalURL + state + "/" + date + ".json");

      final Response response = await dio.get(_singleStateHistoricalURL + state + "/" + date + ".json");
      final jsonResult = json.decode(response.toString());

      print(response);

      return StateHistoricalStats.fromJson(jsonResult);
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
      for(int i = 0; i <response.data['message'].length; i++) {
        resultsList.add(USCountyStats.fromJson(response.data['message'][i]));
      }
      filteredResultsList = resultsList.where((county) => county.stateName == stateName).toList();

      return filteredResultsList;
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Get results from sheetlabs NCOR for all covid testing centers in the us
  Future<List<TestingCenter>> getUSTestingCenters(String stateAbr) async {
    final List resultsList = List();
    List<TestingCenter> testingCentersList = List();

    try {
      final Response response = await dio.get(_usTestingCentersURL + stateAbr);
      for(int i = 0; i <response.data.length; i++) {
        resultsList.add(response.data[i]);
      }

      testingCentersList = resultsList.map<TestingCenter>((json) =>
        TestingCenter.fromJson(json)).toList();

      return testingCentersList;
    } catch (e) {
      print(e);
      return e;
    }
  }
}