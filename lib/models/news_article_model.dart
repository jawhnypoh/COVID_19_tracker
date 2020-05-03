// NewsArticleModel Class for individual News Articles
class NewsArticleModel {
  String path;
  String title;
  String excerpt;
  String webURL;
  String publishedDateTime;
  ProviderInfo providerInfo;
  List<ArticleImage> articleImages;

  NewsArticleModel({
    this.path,
    this.title,
    this.excerpt,
    this.webURL,
    this.publishedDateTime,
    this.providerInfo,
    this.articleImages,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> parsedJSON) => NewsArticleModel(
    path: parsedJSON['path'],
    title: parsedJSON['title'],
    excerpt: parsedJSON['excerpt'],
    webURL: parsedJON['webUrl'],
    publishedDateTime: parsedJSON['publishedDateTime'],
    providerInfo: ProviderInfo.fromJSON(parsedJSON['name']),
    articleImages: List<ArticleImage>.from(parsedJSON['images'].map((x) =>
        ArticleImage.fromJSON(x))),
  );

  Map<String, dynamic> toJSON() => {
    'path': path,
    'title': title,
    'excerpt': excerpt,
    'webUrl': webURL,
    'publishedDateTime': publishedDateTime,
    'providerInfo': providerInfo.toJSON(),
    'articleImages': List<dynamic>.from(articleImages.map((x => x.toJSON(x))),
  };
}

// ProviderInfo Class for News Provider
class ProviderInfo {
  String name;

  ProviderInfo({
    this.name,
  });

  factory Provider.fromJSON(Map<String, dynamic> parsedJSON) => ProviderInfo(
    name: parsedJSON['name'],
  );

  Map<String, dynamic> toJSON() => {
    'name': name,
  };
}

// ArticleImage Class for News Image
class ArticleImage {
  String imageURL;

  ArticleImage({
    this.imageURL,
  });

  factory ArticleImage.fromJson(Map<String, dynamic> parsedJSON) => ArticleImage(
    imageURL: parsedJSON['url'],
  );

  Map<String, dynamic> toJSON() => {
    'imageURL': imageURL,
  }
}