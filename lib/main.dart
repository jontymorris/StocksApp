import 'package:flutter/material.dart';
import 'icons/finance.dart';
import 'widgets/news_widget.dart';

void main() {
  runApp(StockApp());
}

class StockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            labelColor: Colors.blueGrey,
            indicatorColor: Colors.blueGrey,
            tabs: [
              Tab(icon: Icon(Finance.list)),
              Tab(icon: Icon(Finance.newspaper)),
              Tab(icon: Icon(Finance.money_bill_wave)),
              Tab(icon: Icon(Finance.glasses)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
          body: TabBarView(
            children: [
              _buildSimpleText('Stock listings'),
              NewsFeedWidget(),
              _buildSimpleText('Upcoming dividends'),
              _buildSimpleText('Learn to invest'),
              _buildSimpleText('Settings page')
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleText(String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(value),
        )
      ],
    );
  }
}
