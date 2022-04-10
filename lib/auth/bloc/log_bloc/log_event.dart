import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginWithCredentials extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentials({required this.password, required this.email});

  @override
  List<Object?> get props => [email, password];
}
