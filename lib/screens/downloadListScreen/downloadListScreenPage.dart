import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/configs.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/screens/downloadListScreen/downloadListScreenWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadListPage extends StatefulWidget {
  DownloadListPage({
    Key key,
  }) : super(key: key);
  @override
  _DownloadListPageState createState() => _DownloadListPageState();
}

class _DownloadListPageState extends State<DownloadListPage> {
  _DownloadListPageState();
  double height, width;
  SharedPreferences prefs;

  bool downloadFetch = false;

  List<Map> dataDownload = [];

  getCategoryTappingData() async {
    prefs = await SharedPreferences.getInstance();

    var downloadString = prefs.getString('downloads');

    if (downloadString != null) {
      var tempArray = downloadString.split("//");

      for (var i = 0; i < tempArray.length - 1; i++) {
        var tempArrayObject = tempArray[i].toString().split("\\");
        dataDownload.add({
          'audioLink': '${tempArrayObject[0]}',
          'tappingKey': '${tempArrayObject[1]}',
          'title': '${tempArrayObject[2]}',
        });
      }
      setState(() {
        downloadFetch = true;
      });
    } else {
      setState(() {
        downloadFetch = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryTappingData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [darkModerateBlue2, veryDarkBlue]),
          ),
          child: Column(
            children: [
              GradientAppBar("Downloads", true, veryDarkGrayishViolet,
                  blueVeryDark.withOpacity(1), white),
              Container(
                height: height * 0.885,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: defaultPadding * 0.5,
                      ),
                      downloadFetch
                          ? dataDownload.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.all(
                                      defaultPadding * 0.5),
                                  child: Column(
                                    children: [
                                      buildDownloadDataList(
                                          dataDownload, height, width, context)
                                    ],
                                  ),
                                )
                              : noDataDoundWidget(height)
                          : buildCPIWidget(height, width)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
