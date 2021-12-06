import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/models/tappingDataModel.dart';
import 'package:foodfreedomapp/screens/tappingDetailsScreen/tappingDetailsScreenPage.dart';

Widget buildHorizontalScrollTappingList(List<TappingDataModel> tappingList,
    double height, double width, BuildContext context, onResume) {
  return Container(
    child: Column(
      children: [
        Container(
          height: height * 0.2,
          width: width * 0.9,
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 15, right: 15, top: 15),
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: tappingList.length < 15 ? tappingList.length : 15,
              addAutomaticKeepAlives: false,
              itemBuilder: (BuildContext context, int index) {
                TappingDataModel tappingObject = tappingList[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => TappingDetailsPage(
                                tappingDetailsObject: tappingObject,
                              ),
                            ),
                          )
                          .then(onResume);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        child: Container(
                          height: height * 0.17,
                          width: height * 0.17,
                          decoration: BoxDecoration(
                              color: veryDarkGrey2.withOpacity(0.45)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  height: height * 0.17,
                                  width: height * 0.17,
                                  child: FadeInImage.assetNetwork(
                                    imageErrorBuilder: (i, j, k) => Image(
                                        image: AssetImage("assets/logo.png")),
                                    placeholder: "assets/logo.png",
                                    image: "${tappingObject.image}",
                                    fit: BoxFit.cover,
                                  )),
                              Container(
                                height: height * 0.17,
                                width: height * 0.17,
                                decoration: BoxDecoration(
                                    color: black.withOpacity(0.3)),
                              ),
                              Container(
                                height: height * 0.17,
                                width: height * 0.1,
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
                        ),
                      ),
                    ));
              }),
        ),
      ],
    ),
  );
}
