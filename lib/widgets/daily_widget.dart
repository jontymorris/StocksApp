import 'package:StocksApp/widgets/load_widget.dart';
import 'package:flutter/material.dart';
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
              List<Widget> listItems =
                  snapshot.data.map((e) => _buildDaily(e)).toList();

              return ListView(
                children: listItems,
              );
            }

            return LoadingWidget();
          }),
    );
  }

  Widget _buildDaily(Candle candle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Text(
        candle.close.toString(),
      ),
    );
  }
}
