import 'package:equatable/equatable.dart';
import 'package:projects/auth/model/user_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends ProfileState {}

class LoadingState extends ProfileState {}

class LoadedState extends ProfileState {
  final UserData? userData;

  LoadedState([this.userData]);
}

class ErrorState extends ProfileState {}
