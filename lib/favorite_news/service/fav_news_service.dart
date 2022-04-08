import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/favorite_news/model/fav_news_model.dart';
import 'package:projects/favorite_news/repository/fav_news_repo.dart';
import 'package:projects/news/model/news_model.dart';

abstract class FavNewsService {
  Future<FavoriteNewsData?> getFavNews();

  Future<List<bool>> isFavNews(List<NewsData> news);

  Future addToFavWords(NewsData news);

  Future deleteToFavWords(NewsData news);
}

class FavNewsServiceImpl implements FavNewsService {
  final FavoriteNewsRepoImpl _favoriteNewsRepoImpl = FavoriteNewsRepoImpl();

  @override
  Future<FavoriteNewsData?> getFavNews() async {
    try {
      FavoriteNewsData? _favNewsData =
          await _favoriteNewsRepoImpl.getUsersFavNews();
      return _favNewsData;
    } catch (e) {
      print('Get Fav News: $e');
    }
    return null;
  }

  @override
  Future<List<bool>> isFavNews(List<NewsData> news) async {
    FavoriteNewsData? _favoriteNews = await getFavNews();
    return news
        .map((e) => _favoriteNews != null && _favoriteNews.newsData.contains(e))
        .toList();
  }

  @override
  Future addToFavWords(NewsData news) async {
    try {
      FavoriteNewsData? _favoriteNews = await getFavNews();
      if (_favoriteNews != null && !_favoriteNews.newsData.contains(news)) {
        _favoriteNews.newsData.add(news);
        print(news.title);
        await _favoriteNewsRepoImpl.updateFavoriteNews(_favoriteNews);
      }
    } catch (e) {
      print('Update: $e');
    }
  }

  @override
  Future deleteToFavWords(NewsData news) async {
    try {
      FavoriteNewsData? _favoriteNews = await getFavNews();
      if (_favoriteNews != null && _favoriteNews.newsData.contains(news)) {
        _favoriteNews.newsData.remove(news);
        await _favoriteNewsRepoImpl.updateFavoriteNews(_favoriteNews);
      }
    } catch (e) {
      print('Delete: $e');
    }
  }
}
