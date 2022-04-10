import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/auth/bloc/reg_bloc/reg_event.dart';
import 'package:projects/auth/bloc/reg_bloc/reg_state.dart';
import 'package:projects/auth/service/user_repository.dart';
import 'package:projects/auth/utils/firebase_exception.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  final UserRepository _userRepository;

  RegBloc(this._userRepository) : super(RegInitial()) {
    on<RegWithCredentialsPressed>((event, emit) =>
        _mapRegWithCredentialsPressedToState(emit,
            password: event.password, email: event.email, name: event.name));
  }

  Future<void> _mapRegWithCredentialsPressedToState(Emitter emit,
      {required String password,
      required String email,
      required String name}) async {
    emit(RegLoading());
    try {
      await _userRepository.singUp(
          email: email, password: password, name: name);

      emit(RegSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegFailed(checkError(e.code)));
    }
  }
}
