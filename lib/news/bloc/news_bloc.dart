import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/favorite_news/repository/fav_news_repo.dart';
import 'package:projects/favorite_news/service/fav_news_service.dart';
import 'package:projects/news/bloc/news_event.dart';
import 'package:projects/news/bloc/news_state.dart';
import 'package:projects/news/model/news_model.dart';
import 'package:projects/news/repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  final FavNewsServiceImpl _favWordsServiceImpl;

  NewsBloc(this._newsRepository, this._favWordsServiceImpl)
      : super(InitialState()) {
    on<GetAllNewsEvent>(((event, emit) => _mapGetAllNews(emit)));
    on<SearchByContentEvent>(
        (event, emit) => _mapGetNewsByContent(emit, event.content));
  }

  Future<void> _mapGetAllNews(Emitter emit) async {
    emit(LoadingState());
    try {
      List<NewsData> newsData = await _newsRepository.getAllNews();
      List<bool> isFav = await _favWordsServiceImpl.isFavNews(newsData);
      emit(SuccessState(newsData, isFav));
    } catch (e) {
      print(e);
      emit(ErrorState());
    }
  }

  Future<void> _mapGetNewsByContent(Emitter emit, content) async {
    emit(LoadingState());
    try {
      List<NewsData> newsData =
          await _newsRepository.searchNewsByContent(content);
      List<bool> isFav = await _favWordsServiceImpl.isFavNews(newsData);
      emit(SuccessState(newsData, isFav));
    } catch (e) {
      emit(ErrorState());
      throw Exception(e);
    }
  }
}
