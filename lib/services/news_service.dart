import 'dart:convert';
import 'package:StocksApp/model/article.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

const _source = baseUrl + 'api/news';

Future<List<Article>> getNewsFeed() async {
  var response = await http.get(_source);
  Iterable articles = jsonDecode(response.body);

  return articles.map((e) => Article.fromJson(e)).toList();
}
