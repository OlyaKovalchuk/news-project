import 'package:equatable/equatable.dart';
import 'package:projects/news/model/news_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends NewsState {}

class LoadingState extends NewsState{}

class SuccessState extends NewsState{
 final List<NewsData> newsData;

 SuccessState(this.newsData);
}

class ErrorState extends NewsState{}
