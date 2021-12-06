import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({
    Key key,
    this.link,
    this.text,
  }) : super(key: key);
  final String link;
  final String text;
  @override
  _WebViewScreenState createState() => _WebViewScreenState(link, text);
}

class _WebViewScreenState extends State<WebViewScreen> {
  String link;
  String text;

  _WebViewScreenState(this.link, this.text);
  double height, width;

  SharedPreferences prefs;

  bool isLoading = true;

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          appBar: appBarWithBackButton(context, "$text", () {
            Navigator.pop(context);
          }),
          body: Column(children: [
            Stack(
              children: [
                Container(
                  height: height - MediaQuery.of(context).padding.top - 65,
                  width: width,
                  child: WebView(
                    initialUrl: "$link",
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                ),
                Container(
                  height: height - MediaQuery.of(context).padding.top - 65,
                  width: width,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                )
              ],
            )
          ])),
    );
  }
}
