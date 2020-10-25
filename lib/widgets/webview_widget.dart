import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final url;
  final title;

  WebViewWidget(this.url, this.title);

  @override
  createState() => _WebViewState(this.url, this.title);
}

class _WebViewState extends State<WebViewWidget> {
  final _url;
  final _title;

  _WebViewState(this._url, this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url,
            ),
          ),
        ],
      ),
    );
  }
}
