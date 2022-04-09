import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/auth/bloc/log_bloc/log_event.dart';
import 'package:projects/auth/bloc/log_bloc/log_state.dart';
import 'package:projects/auth/service/user_repository.dart';
import 'package:projects/auth/utils/firebase_exception.dart';

class LogBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LogBloc(this._userRepository) : super(LogInitial()) {
    on<LoginWithCredentials>((event, emit) =>
        _mapLoginWithCredentialsPressedToState(
            emit, password: event.password, email: event.email));
  }

  Future<void> _mapLoginWithCredentialsPressedToState(Emitter emit,
      {required String password, required String email}) async {
    try {
      await _userRepository.signInWithCredentials(email, password);
      emit(LogSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LogFailed(checkError(e.code)));
    }
  }
}
