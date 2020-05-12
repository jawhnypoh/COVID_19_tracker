// NewsArticleModel Class for individual News Articles
import 'dart:convert';

NewsArticleModel newsArticleModelFromJson(String str) => NewsArticleModel.fromJson(json.decode(str));

String newsArticleModelToJson(NewsArticleModel data) => json.encode(data.toJson());

class NewsArticleModel {
  String kind;
  Data data;

  NewsArticleModel({
    this.kind,
    this.data,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) => NewsArticleModel(
    kind: json["kind"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "data": data.toJson(),
  };
}

class Data {
  dynamic approvedAtUtc;
  String subreddit;
  String selftext;
  String authorFullname;
  bool saved;
  dynamic modReasonTitle;
  String title;
  String subredditNamePrefixed;
  String name;
  bool quarantine;
  int ups;
  MediaEmbed mediaEmbed;
  dynamic category;
  String linkFlairText;
  int score;
  String thumbnail;
  double created;
  String domain;
  String suggestedSort;
  bool mediaOnly;
  String author;
  String permalink;
  String url;
  int subredditSubscribers;
  double createdUtc;
  dynamic media;
  bool isVideo;

  Data({
    this.approvedAtUtc,
    this.subreddit,
    this.selftext,
    this.authorFullname,
    this.saved,
    this.modReasonTitle,
    this.title,
    this.subredditNamePrefixed,
    this.name,
    this.quarantine,
    this.ups,
    this.mediaEmbed,
    this.category,
    this.linkFlairText,
    this.score,
    this.thumbnail,
    this.created,
    this.domain,
    this.suggestedSort,
    this.mediaOnly,
    this.author,
    this.permalink,
    this.url,
    this.subredditSubscribers,
    this.createdUtc,
    this.media,
    this.isVideo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    approvedAtUtc: json["approved_at_utc"],
    subreddit: json["subreddit"],
    selftext: json["selftext"],
    authorFullname: json["author_fullname"],
    saved: json["saved"],
    modReasonTitle: json["mod_reason_title"],
    title: json["title"],
    subredditNamePrefixed: json["subreddit_name_prefixed"],
    name: json["name"],
    quarantine: json["quarantine"],
    ups: json["ups"],
    mediaEmbed: MediaEmbed.fromJson(json["media_embed"]),
    category: json["category"],
    linkFlairText: json["link_flair_text"],
    score: json["score"],
    thumbnail: json["thumbnail"],
    created: json["created"],
    domain: json["domain"],
    suggestedSort: json["suggested_sort"],
    mediaOnly: json["media_only"],
    author: json["author"],
    permalink: json["permalink"],
    url: json["url"],
    subredditSubscribers: json["subreddit_subscribers"],
    createdUtc: json["created_utc"],
    media: json["media"],
    isVideo: json["is_video"],
  );

  Map<String, dynamic> toJson() => {
    "approved_at_utc": approvedAtUtc,
    "subreddit": subreddit,
    "selftext": selftext,
    "author_fullname": authorFullname,
    "saved": saved,
    "mod_reason_title": modReasonTitle,
    "title": title,
    "subreddit_name_prefixed": subredditNamePrefixed,
    "name": name,
    "quarantine": quarantine,
    "ups": ups,
    "media_embed": mediaEmbed.toJson(),
    "category": category,
    "link_flair_text": linkFlairText,
    "score": score,
    "thumbnail": thumbnail,
    "created": created,
    "domain": domain,
    "suggested_sort": suggestedSort,
    "media_only": mediaOnly,
    "author": author,
    "permalink": permalink,
    "url": url,
    "subreddit_subscribers": subredditSubscribers,
    "created_utc": createdUtc,
    "media": media,
    "is_video": isVideo,
  };
}

class MediaEmbed {
  MediaEmbed();

  factory MediaEmbed.fromJson(Map<String, dynamic> json) => MediaEmbed(
  );

  Map<String, dynamic> toJson() => {
  };
}

