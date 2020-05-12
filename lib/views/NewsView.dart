// News Screen

import 'package:covid_19_tracker/models/news_article_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:covid_19_tracker/views/NewsURLView.dart';
import 'package:flutter/material.dart';

class NewsViewState extends State<NewsView> {
  Future<List<NewsArticleModel>> newsArticles;
  ScrollController _scrollController = ScrollController();

  NewsViewState() {}

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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('News'),
        ),
      body: FutureBuilder(
        future: ApiResources().getNewsArticleResults(),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? _buildNewsListView(snapshot.data)
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.all(100.0),
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildNewsListView(List<NewsArticleModel> newsArticles) {
    return Container(
      child: ListView.separated(
          itemCount: newsArticles == null ? 0 : newsArticles.length,
          itemBuilder: (context, idx) {
            return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                leading: newsArticles[idx].data.thumbnail == "self"
                    ? Container(width: 80.0, height: 50.0,
                        child: Text('No Image Available',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      )
                    : Image.network(newsArticles[idx].data.thumbnail,
                      width: 80.0, height: 50.0,
                ),
                title: Text(newsArticles[idx].data.title,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                subtitle: Text('Published by ' + newsArticles[idx].data.domain,
                  style: const TextStyle(fontSize: 15.0)
                ),
              onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsURLView(newsURL: newsArticles[idx].data.url))
                  );
              },
              );
          },
          separatorBuilder: (context, idx) {
            return Divider();
          },
          controller: _scrollController,
      ),
    );
  }
}

class NewsView extends StatefulWidget {
  const NewsView({Key key}) : super(key : key);

  @override
  NewsViewState createState() => NewsViewState();
}
