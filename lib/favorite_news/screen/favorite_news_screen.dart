import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:projects/favorite_news/bloc/fav_news_bloc.dart';
import 'package:projects/favorite_news/bloc/fav_news_state.dart';
import 'package:projects/favorite_news/service/fav_news_service.dart';
import 'package:projects/widgets/empty_view.dart';
import 'package:projects/news/screen/all_news_screen.dart';
import 'package:projects/widgets/app_bar_builder.dart';
import 'package:projects/widgets/error_view.dart';
import 'package:projects/widgets/loading_view.dart';

import '../bloc/fav_news_event.dart';

class FavoriteNewsScreen extends StatelessWidget {
  FavoriteNewsScreen({Key? key}) : super(key: key);
  final FavNewsBloc _favNewsBloc = FavNewsBloc(FavNewsServiceImpl());
  final DateFormat dateTime = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: appBarBuilder(
        leading: const BackButton(),
        title: 'Favorite News',
      ),
      body: SizedBox(
          child: BlocBuilder(
              bloc: _favNewsBloc..add(GetFavNews()),
              builder: (context, state) {
                if (state is SuccessState) {
                  if (state.favNewsData!.isNotEmpty) {
                    return NewsListTile(
                      newsData: state.favNewsData!,
                      isFav: state.isFavorite!,
                    );
                  } else {
                    return const EmptyView(
                      text: 'You don\'t have favorites news yet!',
                    );
                  }
                } else if (state is LoadingState) {
                  return const LoadingView();
                } else if (state is FailedState) {
                  return const ErrorView();
                }
                return const ErrorView();
              })),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AllNewsScreen()));
      },
    );
  }
}
