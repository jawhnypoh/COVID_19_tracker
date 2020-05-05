// News URL Screen

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsURLViewState extends State<NewsURLView> {
  String newsURL;

  NewsURLViewState(this.newsURL);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: newsURL,
      withJavascript: true,
      hidden: true,
      withZoom: true,
      appBar: AppBar(),
    );
  }
}

class NewsURLView extends StatefulWidget {
  // Declare newsURL that holds news article URL
  final String newsURL;

  // Require newsURL in constructor
  NewsURLView({Key key, @required this.newsURL}) : super(key : key);

  @override
  NewsURLViewState createState() => NewsURLViewState(newsURL);
}