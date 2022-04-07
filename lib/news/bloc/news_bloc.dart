import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/news/bloc/news_event.dart';
import 'package:projects/news/bloc/news_state.dart';
import 'package:projects/news/model/news_model.dart';
import 'package:projects/news/repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;

  NewsBloc(this._newsRepository) : super(InitialState()) {
    on<GetAllNewsEvent>(((event, emit) => _mapGetAllNews(emit)));
    on<SearchByContentEvent>(
        (event, emit) => _mapGetNewsByContent(emit, event.content));
  }

  Future<void> _mapGetAllNews(Emitter emit) async {
    emit(LoadingState());
    try {
      List<NewsData> newsData = await _newsRepository.getAllNews();

      emit(SuccessState(newsData));
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future<void> _mapGetNewsByContent(Emitter emit, content) async {
    emit(LoadingState());
    try {
      List<NewsData> newsData =
          await _newsRepository.searchNewsByContent(content);

      emit(SuccessState(newsData));
    } catch (e) {
      throw Exception(e);
    }
  }
}
