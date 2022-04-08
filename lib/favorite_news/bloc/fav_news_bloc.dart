import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/favorite_news/bloc/fav_news_event.dart';
import 'package:projects/favorite_news/bloc/fav_news_state.dart';
import 'package:projects/favorite_news/model/fav_news_model.dart';
import 'package:projects/favorite_news/service/fav_news_service.dart';
import 'package:projects/news/model/news_model.dart';

class FavNewsBloc extends Bloc<FavNewsEvent, FavNewsState> {
  final FavNewsService _favoriteNewsService;

  FavNewsBloc(this._favoriteNewsService) : super(InitialState()) {
    on<GetFavNews>((event, emit) => getFavNews(emit));
    on<SetFavNews>((event, emit) => setFavNews(emit, event.newsData));
    on<DeleteFavNews>((event, emit) => deleteFavNews(emit, event.newsData));
  }

  Future<void> getFavNews(
    Emitter emit,
  ) async {
    emit(LoadingState());
    try {
      FavoriteNewsData? _favNewsList = await _favoriteNewsService.getFavNews();
      if (_favNewsList != null) {
        List<bool> isFav =
            await _favoriteNewsService.isFavNews(_favNewsList.newsData);
        emit(SuccessState(
            favNewsData: _favNewsList.newsData, isFavorite: isFav));
      }
    } catch (e) {
      emit(FailedState());
    }
  }

  Future<void> setFavNews(Emitter emit, NewsData newsData) async {
    emit(LoadingState());
    try {
      await _favoriteNewsService.addToFavWords(newsData);

      emit(SuccessState());
    } catch (e) {
      emit(FailedState());
    }
  }

  Future<void> deleteFavNews(Emitter emit, NewsData newsData) async {
    emit(LoadingState());
    try {
      await _favoriteNewsService.deleteToFavWords(newsData);
      emit(SuccessState());
    } catch (e) {
      emit(FailedState());
    }
  }
}
