import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/models/tappingDataModel.dart';
import 'package:foodfreedomapp/screens/tappingDetailsScreen/tappingDetailsScreenPage.dart';

Widget buildVerticalGridScrollTappingList(List<TappingDataModel> tappingList,
    double height, double width, BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          height: height * 0.9,
          child: GridView.builder(
              padding: EdgeInsets.only(bottom: 50),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 7.0,
                  mainAxisSpacing: 15.0),
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: tappingList.length,
              itemBuilder: (BuildContext context, int index) {
                TappingDataModel tappingObject = tappingList[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TappingDetailsPage(
                            tappingDetailsObject: tappingObject,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      child: Container(
                          decoration: BoxDecoration(
                              color: veryDarkGrey2.withOpacity(0.45)),
                          child: Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                    height: height * 0.14,
                                    width: height * 0.14,
                                    child: FadeInImage.assetNetwork(
                                      imageErrorBuilder: (i, j, k) => Image(
                                          image: AssetImage("assets/logo.png")),
                                      placeholder: "assets/logo.png",
                                      image: "${tappingObject.image}",
                                      fit: BoxFit.cover,
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                      color: black.withOpacity(0.3)),
                                ),
                                Container(
                                  child: Center(
                                    child: AutoSizeText(
                                      "${tappingObject.title}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ));
              }),
        ),
      ],
    ),
  );
}
