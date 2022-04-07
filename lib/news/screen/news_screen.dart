import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/favorite_news/screen/favorite_news_screen.dart';
import 'package:projects/news/bloc/news_bloc.dart';
import 'package:projects/news/bloc/news_event.dart';
import 'package:projects/news/bloc/news_state.dart';
import 'package:projects/news/model/news_model.dart';
import 'package:projects/news/repository/news_repository.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsBloc _newsBloc = NewsBloc(NewsRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.star,
              color: Colors.amberAccent,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteNewsScreen()));
            },
          ),
          actions: [
            SignOutButton(),
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
                  return NewsListTile(newsData: state.newsData);
                } else if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amberAccent,
                    ),
                  );
                }
                return const Center(
                    child: Text(
                  'Oops..Something goes wrong',
                  style: TextStyle(color: Colors.white),
                ));
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
        style: TextStyle(color: Colors.white),
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

  const NewsListTile({Key? key, required this.newsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: newsData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  tileColor: Colors.transparent,
                  title: Text(
                    newsData[index].author!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    newsData[index].title!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.star_border_outlined,
                      color: Colors.amberAccent,
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _firebaseAuth.signOut();
        },
        icon: const Icon(
          Icons.person,
          color: Colors.amberAccent,
        ));
  }
}
