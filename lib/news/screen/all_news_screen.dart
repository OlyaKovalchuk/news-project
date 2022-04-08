import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/favorite_news/bloc/fav_news_bloc.dart';
import 'package:projects/favorite_news/bloc/fav_news_event.dart';
import 'package:projects/favorite_news/repository/fav_news_repo.dart';
import 'package:projects/favorite_news/screen/favorite_news_screen.dart';
import 'package:projects/favorite_news/service/fav_news_service.dart';
import 'package:projects/favorite_news/widget/fav_news_button.dart';
import 'package:projects/news/bloc/news_bloc.dart';
import 'package:projects/news/bloc/news_event.dart';
import 'package:projects/news/bloc/news_state.dart';
import 'package:projects/news/model/news_model.dart';
import 'package:projects/news/repository/news_repository.dart';
import 'package:projects/news/screen/one_news_screen.dart';

import '../../profile/screen/profile_screen.dart';

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({Key? key}) : super(key: key);

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  final NewsBloc _newsBloc =
      NewsBloc(NewsRepositoryImpl(), FavNewsServiceImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.bookmarks_rounded,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FavoriteNewsScreen()));
            },
          ),
          actions: const [
            ToProfileButton(),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade900,
          centerTitle: true,
          title: const Text(
            'News Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            SearchNewsField(
              newsBloc: _newsBloc,
            ),
            BlocBuilder(
              bloc: _newsBloc..add(GetAllNewsEvent()),
              builder: (context, state) {
                if (state is SuccessState) {
                  return Expanded(
                    child: NewsListTile(
                      newsData: state.newsData,
                      isFav: state.isFavorite,
                    ),
                  );
                } else if (state is LoadingState) {
                  return const CircularProgressIndicator(
                    color: Colors.amberAccent,
                  );
                } else if (state is ErrorState) {
                  return const Center(
                      child: Text(
                    'Oops..Something goes wrong',
                    style: TextStyle(color: Colors.white),
                  ));
                }
                return Container();
              },
            ),
          ],
        ));
  }
}

class SearchNewsField extends StatelessWidget {
  final NewsBloc newsBloc;

  SearchNewsField({Key? key, required this.newsBloc}) : super(key: key);

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Enter keywords',
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey.shade900,
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 15),
        ),
        onSubmitted: (keywords) {
          _focusNode.consumeKeyboardToken();
          if (keywords != '') {
            newsBloc.add(SearchByContentEvent(keywords));
          } else {
            newsBloc.add(GetAllNewsEvent());
          }
        },
      ),
    );
  }
}

class NewsListTile extends StatelessWidget {
  final List<NewsData> newsData;
  final List<bool> isFav;

  const NewsListTile({Key? key, required this.newsData, required this.isFav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: newsData.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                  minLeadingWidth: 10,
                  leading: DetailsButton(
                    newsData: newsData[index],
                  ),
                  tileColor: Colors.transparent,
                  title: Text(
                    newsData[index].source!.name! +
                        ' | ' +
                        newsData[index].author!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    newsData[index].title!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: FavIconButton(
                    newsData: newsData[index],
                    isFavorited: isFav[index],
                  )),
            ));
      },
    );
  }
}

class DetailsButton extends StatelessWidget {
  final NewsData newsData;

  const DetailsButton({Key? key, required this.newsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OneNewsScreen(newsData: newsData)));
      },
      child: const Text(
        'Details',
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}

class ToProfileButton extends StatelessWidget {
  const ToProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ProfileScreen()));
        },
        icon: const Icon(
          Icons.person,
          color: Colors.grey,
        ));
  }
}
