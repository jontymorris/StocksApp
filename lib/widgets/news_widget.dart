import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../model/article.dart';

class NewsFeedWidget extends StatefulWidget {
  NewsFeedWidget({Key key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeedWidget> {
  Future<List<Article>> futureFeed;

  @override
  void initState() {
    super.initState();
    futureFeed = getNewsFeed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: futureFeed,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView(
              children: snapshot.data
                  .map(
                    (e) => InkWell(
                      onTap: () => {},
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(e.title),
                      ),
                    ),
                  )
                  .toList(),
            );

          return Center(
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()));
        });
  }
}
