import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/auth/service/user_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc(this._userRepository) : super(AuthInitial()) {
    on<AuthStarted>((event, emit) => _mapAuthStarted(emit));
    on<AuthLoggedIn>((event, emit) => _mapAuthLoggedIn(emit));
  }

  Future<void> _mapAuthLoggedIn(Emitter<AuthState> emit) async {
    emit(AuthOnSuccess(user: await _userRepository.getUser()));
  }

  Future<void> _mapAuthStarted(Emitter<AuthState> emit) async {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final user = await _userRepository.getUser();
      emit(AuthOnSuccess(user: user));
    } else {
      emit(AuthFailed());
    }
  }
}
