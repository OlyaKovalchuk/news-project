import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllNewsEvent extends NewsEvent {}

class SearchByContentEvent extends NewsEvent {
  final String content;

  SearchByContentEvent(this.content);
}
