import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';

class GradientAppBarAudioPlayer extends StatelessWidget {
  final double barHeight = 60.0;
  final String title;

  GradientAppBarAudioPlayer(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.5,
          child: new Container(
            padding: EdgeInsets.only(top: statusbarHeight),
            height: statusbarHeight + barHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [veryDarkGrayishViolet, mostlyDarkDesaturatedOrange],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, top: statusbarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: white,
                    size: 25.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: 20,
              ),
              Container(
                width: width * 0.65,
                child: Center(
                  child: AutoSizeText(
                    "$title",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    maxFontSize: 16,
                    minFontSize: 12,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

InkWell buttonOptionsAudioPlayer(image, onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Column(
      children: [
        Center(
          child: Container(
            height: image == "assets/play.png" || image == "assets/pause.png"
                ? 65
                : 50,
            width: image == "assets/play.png" || image == "assets/pause.png"
                ? 65
                : 50,
            child: Image.asset(
              "$image",
            ),
          ),
        ),
      ],
    ),
  );
}

void showDialogBoxComplition(context, text, description, onPressed) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Center(child: Text(text)),
          backgroundColor: blueSoft,
          actionsPadding: EdgeInsets.only(bottom: 10),
          content: SingleChildScrollView(
              child: Center(
                  child: Text(
            description,
            textAlign: TextAlign.center,
          ))),
          actions: [Center(child: buttonRegular(onPressed, "Done"))],
        );
      });
}
