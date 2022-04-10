import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/auth/model/user_model.dart';
import 'package:projects/profile/bloc/profile_event.dart';
import 'package:projects/profile/bloc/profile_state.dart';

import '../../auth/service/fire_user_rep.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FireUsersDataRepo _repository;

  ProfileBloc(this._repository) : super(InitialState()) {
    on<LoadProfileEvent>((event, emit) => _getProfileInfo(emit));
    on<SignOutEvent>((event, emit) => _signOut(emit));
  }

  Future<void> _getProfileInfo(Emitter emit) async {
    emit(LoadingState());
    try {
      UserData? _userData = await _repository.getUser();
      if (_userData != null) {
        emit(LoadedState(_userData));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _signOut(Emitter emit) async {
    try {
      await _repository.signOut();
      emit(LoadedState());
    } catch (e) {
      throw Exception(e);
    }
  }
}
