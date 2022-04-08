import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projects/news/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OneNewsScreen extends StatelessWidget {
  final NewsData newsData;

  const OneNewsScreen({Key? key, required this.newsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (newsData.urlToImage != null)
                    Image.network(
                      newsData.urlToImage!,
                      width: 170,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(
                    width: 20,
                  ),
                  TitleText(
                    author: newsData.author!,
                    title: newsData.title!,
                    source: newsData.source!.name!,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              DescriptionText(
                description: newsData.description ?? '',
              ),
              const SizedBox(
                height: 15,
              ),
              ContentText(content: newsData.content ?? ''),
              const SizedBox(
                height: 30,
              ),
              PublishedText(
                publishedAt:
                    DateTime.parse(newsData.publishedAt!.toString()),
              ),
              const SizedBox(
                height: 10,
              ),
              LinkOfNews(url: newsData.url ?? '')
            ],
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String author;
  final String title;
  final String source;

  const TitleText(
      {Key? key,
      required this.author,
      required this.title,
      required this.source})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(author,
              style: const TextStyle(
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Source: $source',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  final String content;

  const ContentText({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        content,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String description;

  const DescriptionText({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: <TextSpan>[
      const TextSpan(
        text: 'Description: ',
        style: TextStyle(color: Colors.amberAccent, fontSize: 12),
      ),
      TextSpan(
          text: description,
          style: const TextStyle(color: Colors.white, fontSize: 12)),
    ]));
  }
}

class PublishedText extends StatelessWidget {
  final DateTime publishedAt;

  PublishedText({Key? key, required this.publishedAt}) : super(key: key);

  final DateFormat dateTime = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: <TextSpan>[
      const TextSpan(
        text: 'Published: ',
        style: TextStyle(color: Colors.amberAccent),
      ),
      TextSpan(
          text: dateTime.format(publishedAt),
          style: const TextStyle(color: Colors.white)),
    ]));
  }
}

class LinkOfNews extends StatelessWidget {
  final String url;

  const LinkOfNews({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Follow the link: ',
          style: TextStyle(color: Colors.amberAccent),
        ),
        Expanded(
          child: TextButton(
              onPressed: () {
                _launchURL(url);
              },
              child: Text(url, style: const TextStyle(color: Colors.white))),
        )
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
