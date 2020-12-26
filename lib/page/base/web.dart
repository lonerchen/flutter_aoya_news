

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  final String url;

  WebViewPage(this.url);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  WebViewController _webViewController;

  String title = "加载中...";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseWidget.getBaseAppBar(
        title,
        color: Colors.white,
        onBack: (){
          _webViewController.canGoBack().then((isBack) {
            if (isBack) {
              _webViewController.goBack();
            } else {
              Navigator.pop(context);
            }
          });
        }
      ),
      body: WillPopScope(
        onWillPop: ()async{
          await _webViewController.canGoBack().then((isBack) {
            if (isBack) {
              _webViewController.goBack();
              return false;
            }
          });
          return true;
        },
        child: WebView(
          initialUrl: widget.url,
          onWebViewCreated: (controller)async{
            _webViewController = controller;
            title = await _webViewController.getTitle();
            setState(() {

            });
          },

        ),
      ),
    );
  }
}
