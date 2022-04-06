import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/auth/model/user_model.dart';

import 'fire_user_rep.dart';

abstract class UserRepository {
  Future signInWithCredentials(String email, String password);

  Future<User?> getUser();

  singUp(
      {required String email, required String name, required String password});

  Future signOut();

  Future<bool> isSignedIn();
}

class UserRepositoryImpl implements UserRepository {
  final FireUsersDataRepo _fireUsersDataRepo = FireUsersDataRepoImpl();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future signInWithCredentials(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    print(userCredential);
  }

  @override
  Future<void> singUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      User? user = userCredential.user;
      print('User: $user');
      _createNewUser(user, name);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  @override
  Future signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  _createNewUser(User? user, [String? name]) async {
    if (user != null) {
      final UserData? _getUser = await _fireUsersDataRepo.getUser(user.uid);
      print(user.email);
      if (_getUser == null) {
        print(_getUser);
        if (user.displayName == null) {
          _firebaseAuth.currentUser!.updateDisplayName(name);
        }
        if (user.photoURL == null) {
          _firebaseAuth.currentUser!.updatePhotoURL(
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
        }
        UserData _userData = UserData(
          uid: user.uid,
          name: name ?? user.displayName!,
          email: user.email!,
          photoURL: user.photoURL ??
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        );
        _fireUsersDataRepo.setUser(_userData);
      }
    }
  }
}
