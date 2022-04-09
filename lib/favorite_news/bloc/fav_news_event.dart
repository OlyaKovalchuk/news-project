import 'package:equatable/equatable.dart';
import '../../news/model/news_model.dart';

abstract class FavNewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFavNews extends FavNewsEvent {}

class SetFavNews extends FavNewsEvent {
  final NewsData newsData;

  SetFavNews(this.newsData);

  @override
  List<Object?> get props => [newsData];
}

class DeleteFavNews extends FavNewsEvent {
  final NewsData newsData;

  DeleteFavNews(this.newsData);

  @override
  List<Object?> get props => [newsData];
}
