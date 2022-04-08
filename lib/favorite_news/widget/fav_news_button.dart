import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/favorite_news/bloc/fav_news_bloc.dart';
import 'package:projects/favorite_news/bloc/fav_news_event.dart';
import 'package:projects/favorite_news/bloc/fav_news_state.dart';
import 'package:projects/favorite_news/service/fav_news_service.dart';
import 'package:projects/news/model/news_model.dart';

class FavIconButton extends StatelessWidget {
  final NewsData newsData;
  final bool isFavorited;

  FavIconButton({Key? key, required this.newsData, required this.isFavorited})
      : super(key: key);

  final FavNewsBloc _favNewsBloc = FavNewsBloc(FavNewsServiceImpl());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 30,
        height: 30,
        child: BlocBuilder(
            bloc: _favNewsBloc..add(GetFavNews()),
            builder: (context, state) {
              return FavoriteButton(
                  isFavorite: isFavorited,
                  iconSize: 30,
                  valueChanged: (_isFavorite) {
                    if (_isFavorite) {
                      _favNewsBloc.add(SetFavNews(newsData));
                    } else {
                      _favNewsBloc.add(DeleteFavNews(newsData));
                    }
                  });
            }));
  }
}
