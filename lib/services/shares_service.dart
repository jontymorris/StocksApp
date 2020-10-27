import 'dart:convert';
import 'package:StocksApp/model/share.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

const _source = baseUrl + 'api/shares';

Future<List<Share>> getNewsFeed() async {
  var response = await http.get(_source);
  Iterable shares = jsonDecode(response.body);

  return shares.map((e) => Share.fromJson(e)).toList();
}
