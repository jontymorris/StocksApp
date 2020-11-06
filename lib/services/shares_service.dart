import 'dart:convert';
import 'package:StocksApp/model/share.dart';
import 'package:StocksApp/model/candle.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

const _sharesSource = baseUrl + 'api/shares';
const _dailySource = baseUrl + 'api/daily/';

Future<List<Share>> getShares() async {
  var response = await http.get(_sharesSource);
  Iterable shares = jsonDecode(response.body);

  return shares.map((e) => Share.fromJson(e)).toList();
}

Future<List<Candle>> getDaily(String symbol) async {
  var response = await http.get(_dailySource + symbol);
  Iterable candles = jsonDecode(response.body);

  return candles.map((e) => Candle.fromJson(e)).toList();
}
