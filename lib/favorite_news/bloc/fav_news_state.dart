import 'package:equatable/equatable.dart';
import 'package:projects/favorite_news/model/fav_news_model.dart';
import 'package:projects/news/model/news_model.dart';

abstract class FavNewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends FavNewsState {}

class LoadingState extends FavNewsState {}

class SuccessState extends FavNewsState {
  final List<bool>? isFavorite;
  final List<NewsData>? favNewsData;

  SuccessState({
    this.favNewsData,
    this.isFavorite,
  });
}

class FailedState extends FavNewsState {}
