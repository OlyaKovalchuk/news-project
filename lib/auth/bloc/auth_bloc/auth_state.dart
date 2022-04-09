import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthOnSuccess extends AuthState {
  final User? user;

  AuthOnSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthFailed extends AuthState {}
