import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/favorite_news/model/fav_news_model.dart';

abstract class FavoriteNewsRepo {
  Future<void> setFavoriteWord(FavoriteNewsData news);

  Future<void> updateFavoriteNews(FavoriteNewsData favNews);

  Future<FavoriteNewsData?> getUsersFavNews();
}

class FavoriteNewsRepoImpl implements FavoriteNewsRepo {
  final CollectionReference _favoriteNewsCollection =
      FirebaseFirestore.instance.collection('favoriteNews');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> setFavoriteWord(FavoriteNewsData news) async {
    try {
      await _favoriteNewsCollection.doc(news.uid).set(news.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateFavoriteNews(FavoriteNewsData favNews) async {
    await _favoriteNewsCollection
        .doc(_firebaseAuth.currentUser!.uid)
        .update(favNews.toMap());
  }

  @override
  Future<FavoriteNewsData?> getUsersFavNews() async {
    DocumentSnapshot documentSnapshot =
        await _favoriteNewsCollection.doc(_firebaseAuth.currentUser!.uid).get();
    if (documentSnapshot.exists) {
      return FavoriteNewsData.fromMap(
          documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
