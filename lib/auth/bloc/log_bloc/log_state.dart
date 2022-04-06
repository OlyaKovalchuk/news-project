import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogInitial extends LoginState {}

class LogLoading extends LoginState {}

class LogSuccess extends LoginState {}

class LogFailed extends LoginState {
  final String error;

  LogFailed(this.error);
}
