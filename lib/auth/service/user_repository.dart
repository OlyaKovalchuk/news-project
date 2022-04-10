import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/auth/model/user_model.dart';
import 'package:projects/favorite_news/model/fav_news_model.dart';
import 'package:projects/favorite_news/repository/fav_news_repo.dart';

import 'fire_user_rep.dart';

abstract class UserRepository {
  Future signInWithCredentials(String email, String password);

  Future<User?> getUser();

  singUp(
      {required String email, required String name, required String password});

  Future<bool> isSignedIn();
}

class UserRepositoryImpl implements UserRepository {
  final FireUsersDataRepo _fireUsersDataRepo = FireUsersDataRepoImpl();
  final FavoriteNewsRepo _favoriteNewsRepo = FavoriteNewsRepoImpl();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future signInWithCredentials(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> singUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      _createNewUser(user, name);
    } catch (e) {
      return Future.error(e);
    }
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

  _createNewUser(User? user, String? name) async {
    if (user != null) {
      final UserData? _getUser = await _fireUsersDataRepo.getUser();
      if (_getUser == null) {
        UserData _userData = UserData(
          uid: user.uid,
          name: name ?? user.displayName!,
          email: user.email!,
          photoURL: user.photoURL ??
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        );
        FavoriteNewsData _favNewsData =
            FavoriteNewsData(newsData: [], uid: _userData.uid);
        _favoriteNewsRepo.setFavoriteWord(_favNewsData);
        _fireUsersDataRepo.setUser(_userData);
      }
    }
  }
}
