import 'package:StocksApp/widgets/load_widget.dart';
import 'package:StocksApp/widgets/webview_widget.dart';
import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../model/article.dart';

class NewsFeedWidget extends StatefulWidget {
  NewsFeedWidget({Key key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeedWidget> {
  Future<List<Article>> _futureFeed;

  @override
  void initState() {
    super.initState();
    _futureFeed = getNewsFeed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: _futureFeed,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> listItems = [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'LATEST NEWS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ];

            listItems.addAll(snapshot.data.map((e) => _buildArticle(e)));

            return ListView(
              children: listItems,
            );
          }

          return LoadingWidget();
        });
  }

  Widget _buildArticle(Article article) {
    return InkWell(
      onTap: () => _openArticle(article),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        article.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(article.summary),
                  ],
                ),
              ),
            ),
            Image.network(
              article.icon,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }

  void _openArticle(Article article) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewWidget(article.links, 'Latest news'),
        ));
  }
}
