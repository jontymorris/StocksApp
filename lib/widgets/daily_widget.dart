import 'package:StocksApp/widgets/load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
import 'package:expandable_text/expandable_text.dart';
import '../services/shares_service.dart';
import '../model/share.dart';
import '../model/candle.dart';

class DailyWidget extends StatefulWidget {
  final Share share;

  DailyWidget({Key key, this.share}) : super(key: key);

  @override
  _DailyState createState() => _DailyState(this.share);
}

class _DailyState extends State<DailyWidget> {
  final Share _share;
  Future<List<Candle>> _futureDaily;

  _DailyState(this._share);

  @override
  void initState() {
    super.initState();
    _futureDaily = getDaily(this._share.symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_share.name),
      ),
      body: FutureBuilder<List<Candle>>(
          future: _futureDaily,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var latest = snapshot.data.last;

              return ListView(
                children: [
                  _buildHeader(latest),
                  _buildDescription(),
                  _buildDaily(snapshot.data, 90),
                ],
              );
            }

            return LoadingWidget();
          }),
    );
  }

  Widget _buildHeader(Candle latest) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            _share.logo,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "\$${latest.close}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Icon(
            Icons.favorite_outline_rounded,
            size: 30,
          )
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: ExpandableText(
        _share.description,
        collapseText: 'hide',
        expandText: 'read more',
        maxLines: 4,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDaily(List<Candle> candles, int daysToGoBack) {
    var earliestDate = DateTime.now().subtract(
      new Duration(days: daysToGoBack),
    );

    var data = candles
        .where((e) => e.dateTime.isAfter(earliestDate))
        .map((e) => {
              'open': e.open,
              'high': e.high,
              'low': e.low,
              'close': e.close,
              'volumeto': e.volume
            })
        .toList();

    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Center(
        child: Container(
          height: 350.0,
          child: OHLCVGraph(
            data: data,
            enableGridLines: true,
            volumeProp: 0.2,
            gridLineAmount: 5,
            gridLineColor: Colors.grey[300],
            gridLineLabelColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
