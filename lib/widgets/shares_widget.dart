import 'package:StocksApp/widgets/load_widget.dart';
import 'package:StocksApp/widgets/webview_widget.dart';
import 'package:flutter/material.dart';
import '../services/shares_service.dart';
import '../model/share.dart';

class SharesWidget extends StatefulWidget {
  SharesWidget({Key key}) : super(key: key);

  @override
  _SharesState createState() => _SharesState();
}

class _SharesState extends State<SharesWidget> {
  Future<List<Share>> futureShares;

  @override
  void initState() {
    super.initState();
    futureShares = getShares();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Share>>(
        future: futureShares,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> listItems = [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'SHARE LISTINGS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ];

            listItems.addAll(snapshot.data.map((e) => _buildShare(e)));

            return ListView(
              children: listItems,
            );
          }

          return LoadingWidget();
        });
  }

  Widget _buildShare(Share share) {
    return InkWell(
      onTap: () => _openShare(share),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              share.logo,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  share.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openShare(Share article) {
    // todo: open the share view
  }
}
