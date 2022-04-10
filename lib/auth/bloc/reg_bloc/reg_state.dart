import 'package:equatable/equatable.dart';

abstract class RegState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegInitial extends RegState {}

class RegLoading extends RegState {}

class RegSuccess extends RegState {}

class RegFailed extends RegState {
  final String error;

  RegFailed(this.error);

  @override
  List<Object?> get props => [error];
}
