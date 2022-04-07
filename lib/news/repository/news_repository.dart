import 'dart:convert';

import 'package:http/http.dart';
import 'package:projects/news/model/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsData>> getAllNews();

  Future<List<NewsData>> searchNewsByContent(String content);
}

class NewsRepositoryImpl implements NewsRepository {
  static const String _apiKey = '4cfe69fffefa409c81ebed6dabf69d1a';

  @override
  Future<List<NewsData>> getAllNews() async {
    final queryParameters = {
      'q': 'keyword',
      'sortBy': 'publishedAt',
      'apiKey': _apiKey,
    };
    return await _searchNews(queryParameters);
  }

  @override
  Future<List<NewsData>> searchNewsByContent(String content) async {
    final queryParameters = {
      'q': content,
      'apiKey': _apiKey,
    };
    return await _searchNews(queryParameters);
  }

  Future<List<NewsData>> _searchNews(
      Map<String, dynamic> queryParameters) async {
    var url = Uri.https('newsapi.org', '/v2/everything', queryParameters);
    Response response = await get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(
        response.body,
      );
      List<dynamic> body = map['articles'];

      List<NewsData> _newsData =
          body.map((news) => NewsData.fromJson(news)).toList();
      return _newsData;
    } else {
      throw Exception('There are not news');
    }
  }
}
