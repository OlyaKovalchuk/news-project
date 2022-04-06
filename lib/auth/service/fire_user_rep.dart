import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects/auth/model/user_model.dart';

abstract class FireUsersDataRepo {
  Future<List<UserData>> getUsers();

  Future<UserData?> getUser(String uid);

  setUser(UserData userData);
}

class FireUsersDataRepoImpl implements FireUsersDataRepo {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');


  @override
  Future<List<UserData>> getUsers() async {
    QuerySnapshot usersSnap = await _usersCollection.get();
    List usersList = usersSnap.docs
        .map((e) => UserData.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    return usersList as List<UserData>;
  }

  @override
  Future<UserData?> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await _usersCollection.doc(uid).get();
    if (documentSnapshot.exists) {
      return UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  @override
  setUser(UserData userData) async {
    print(userData);
    try {
      // yes
      await _usersCollection.doc(userData.uid).set(userData.onlyTextMap());

      // Prevent errors on large or corrupted data
      await _usersCollection.doc(userData.uid).update(userData.toMap());
    } catch (e) {
      print(e);
    }
  }
}