import 'package:StocksApp/widgets/load_widget.dart';
import 'package:flutter/material.dart';
import '../services/shares_service.dart';
import '../model/share.dart';
import './daily_widget.dart';

class SharesWidget extends StatefulWidget {
  SharesWidget({Key key}) : super(key: key);

  @override
  _SharesState createState() => _SharesState();
}

class _SharesState extends State<SharesWidget> {
  String _searchQuery;
  Future<List<Share>> _futureShares;

  @override
  void initState() {
    super.initState();
    _searchQuery = '';
    _futureShares = getShares();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Share>>(
        future: _futureShares,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var children = [
              _buildHeader(),
              _buildFilter(),
            ];

            var shares = _sortAndFilterShares(snapshot.data);
            children.addAll(shares.map((e) => _buildShare(e)));

            return ListView(
              children: children,
            );
          }

          return LoadingWidget();
        });
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Text(
        'SHARE LISTINGS',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildFilter() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextField(
        autofocus: false,
        onChanged: (value) => {
          setState(() {
            this._searchQuery = value;
          })
        },
        decoration: InputDecoration(hintText: 'Filter by name'),
      ),
    );
  }

  List<Share> _sortAndFilterShares(List<Share> shares) {
    shares.sort((a, b) => a.name.compareTo(b.name));

    var keywords = this
        ._searchQuery
        .toLowerCase()
        .trim()
        .split(' ')
        .where((e) => e.length > 0)
        .toList();

    if (keywords.length == 0) return shares;

    return shares.where((e) => _containsKeyword(e, keywords)).toList();
  }

  bool _containsKeyword(Share share, List<String> keywords) {
    var name = share.name.toLowerCase();
    for (var keyword in keywords) {
      if (!name.contains(keyword)) return false;
    }

    return true;
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

  void _openShare(Share share) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyWidget(share: share),
        ));
  }
}
