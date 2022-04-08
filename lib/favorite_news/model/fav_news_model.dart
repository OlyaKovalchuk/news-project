import 'dart:convert';
import 'package:projects/news/model/news_model.dart';
import 'package:uuid/uuid.dart';

class FavoriteNewsData {
  final String uid;
  final List<NewsData> newsData;

  FavoriteNewsData({
    String? uid,
    required this.newsData,
  }) : uid = uid ?? const Uuid().v1();

  FavoriteNewsData copyWith({String? uid, List<NewsData>? newsData}) {
    return FavoriteNewsData(uid: uid ?? this.uid, newsData: newsData ?? []);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'favNews': newsData.map((news) => news.toJson()).toList(),
    };
  }

  Map<String, dynamic> onlyTextMap() {
    return {
      'uid': uid,
      'newsData': newsData.map((news) => news.toJson()).toList(),
    };
  }

  factory FavoriteNewsData.fromMap(Map<dynamic, dynamic> map) {
    return FavoriteNewsData(
        uid: map['uid'],
        newsData: List<NewsData>.from(
            map['favNews']?.map((news) => NewsData.fromJson(news))));
  }

  String toJson() => json.encode(toJson());

  @override
  String toString() {
    return 'FavWordData(uid: $uid, words: $newsData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteNewsData &&
        other.uid == uid &&
        other.newsData == newsData;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ newsData.hashCode;
  }
}
