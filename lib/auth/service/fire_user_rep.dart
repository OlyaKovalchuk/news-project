import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/auth/model/user_model.dart';

abstract class FireUsersDataRepo {
  Future<UserData?> getUser();

  Future<void> signOut();

  Future<void> setUser(UserData userData);
}

class FireUsersDataRepoImpl implements FireUsersDataRepo {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserData?> getUser() async {
    DocumentSnapshot documentSnapshot =
        await _usersCollection.doc(_firebaseAuth.currentUser!.uid).get();
    if (documentSnapshot.exists) {
      return UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  @override
  Future<void> setUser(UserData userData) async {
    try {
      await _usersCollection.doc(userData.uid).set(userData.onlyTextMap());
      await _usersCollection.doc(userData.uid).update(userData.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }
}
