import 'package:equatable/equatable.dart';
import 'package:projects/news/model/news_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends NewsState {}

class LoadingState extends NewsState {}

class SuccessState extends NewsState {
  final List<NewsData> newsData;

  final List<bool> isFavorite;

  SuccessState(this.newsData, this.isFavorite);

  @override
  List<Object?> get props => [newsData, isFavorite];
}

class ErrorState extends NewsState {}
