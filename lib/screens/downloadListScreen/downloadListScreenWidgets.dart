import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/screens/audioPlayerDownloadScreen/audioPlayerDownloadScreenPage.dart';

Widget buildDownloadDataList(
    downloadList, double height, double width, BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          height: height * 0.73,
          child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: 50,
              ),
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: downloadList.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (BuildContext context, int index) {
                var downloadDataObject = downloadList[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AudioPlayerDownloadPage(
                            audioLink: downloadDataObject['audioLink'],
                            title: downloadDataObject['title'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: veryDarkGrey2.withOpacity(0.45)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: width * 0.1,
                                        child: FadeInImage(
                                            placeholder: AssetImage(
                                              "assets/logo.png",
                                            ),
                                            image: AssetImage(
                                              "assets/logo.png",
                                            )))
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width * 0.6,
                                      child: AutoSizeText(
                                        "${downloadDataObject['title']}",
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        maxFontSize: 16,
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
        ),
      ],
    ),
  );
}
