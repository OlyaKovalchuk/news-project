import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _firebaseAuth.signOut();
      },
      child: const Text('Sign out'),
    );
  }
}
