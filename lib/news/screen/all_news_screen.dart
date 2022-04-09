import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/auth/widgets/text_field_builder.dart';
import 'package:projects/favorite_news/screen/favorite_news_screen.dart';
import 'package:projects/favorite_news/service/fav_news_service.dart';
import 'package:projects/favorite_news/widget/fav_news_button.dart';
import 'package:projects/news/bloc/news_bloc.dart';
import 'package:projects/news/bloc/news_event.dart';
import 'package:projects/news/bloc/news_state.dart';
import 'package:projects/news/model/news_model.dart';
import 'package:projects/news/repository/news_repository.dart';
import 'package:projects/news/screen/one_news_screen.dart';
import 'package:projects/theme/theme_colors.dart';
import 'package:projects/widgets/app_bar_builder.dart';
import 'package:projects/widgets/empty_view.dart';
import 'package:projects/widgets/error_view.dart';
import 'package:projects/widgets/loading_view.dart';

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
        appBar: appBarBuilder(
            leading: const ToFavoriteButton(),
            actions: const [
              ToProfileButton(),
            ],
            title: 'News Page'),
        body: Column(
          children: [
            SearchNewsField(
              newsBloc: _newsBloc,
            ),
            BlocBuilder(
              bloc: _newsBloc..add(GetAllNewsEvent()),
              builder: (context, state) {
                if (state is SuccessState) {
                  if (state.newsData.isNotEmpty) {
                    return Expanded(
                      child: NewsListTile(
                        newsData: state.newsData,
                        isFav: state.isFavorite,
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: EmptyView(
                        text: 'No such news',
                      ),
                    );
                  }
                } else if (state is LoadingState) {
                  return const Expanded(child: LoadingView());
                } else if (state is ErrorState) {
                  return const Expanded(child: ErrorView());
                }
                return const Expanded(child: ErrorView());
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
      child: TextFieldBuilder(
        hint: 'Enter keywords',
        controller: _controller,
        focusNode: _focusNode,
        onSubmit: (keywords) {
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
        NewsData _newsData = newsData[index];
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                  leading: DetailsButton(
                    newsData: _newsData,
                  ),
                  title: Text(
                    _newsData.source!.name! + ' | ' + _newsData.author!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16),
                  ),
                  subtitle: Text(_newsData.title!,
                      style: Theme.of(context).textTheme.bodyText2),
                  trailing: FavIconButton(
                    newsData: _newsData,
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
      child: Text('Details',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontWeight: FontWeight.normal)),
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
        icon:
            Icon(Icons.person, color: Theme.of(context).colorScheme.onSurface));
  }
}

class ToFavoriteButton extends StatelessWidget {
  const ToFavoriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.bookmarks_rounded,
          color: Theme.of(context).colorScheme.onSurface),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => FavoriteNewsScreen()));
      },
    );
  }
}
