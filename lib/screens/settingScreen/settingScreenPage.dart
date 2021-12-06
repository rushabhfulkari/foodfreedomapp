import 'package:flutter/material.dart';
import 'package:foodfreedomapp/constants/colors.dart';
import 'package:foodfreedomapp/constants/widgets.dart';
import 'package:foodfreedomapp/models/checkInModel.dart';
import 'package:foodfreedomapp/models/tappingActivityDataModel.dart';
import 'package:foodfreedomapp/models/tappingDataModel.dart';
import 'package:foodfreedomapp/screens/accountSettingsScreen/accountSettingsScreenPage.dart';
import 'package:foodfreedomapp/screens/activityScreen/activityScreenPage.dart';
import 'package:foodfreedomapp/screens/appSettingsScreen/appSettingsScreenPage.dart';
import 'package:foodfreedomapp/screens/contactUsScreen/contactUsScreenPage.dart';
import 'package:foodfreedomapp/screens/customizeTappingScreen/customizeTappingScreenPage.dart';
import 'package:foodfreedomapp/screens/introScreen/introScreenPage.dart';
import 'package:foodfreedomapp/screens/reportAProblemScreen/reportAProblemScreenPage.dart';
import 'package:foodfreedomapp/screens/resourcesScreen/resourcesScreenPage.dart';
import 'package:foodfreedomapp/screens/settingScreen/settingPageWidgets.dart';
import 'package:foodfreedomapp/screens/suggestAppFeatureScreen/suggestAppFeatureScreenPage.dart';
import 'package:foodfreedomapp/screens/suggestTappingTopicScreen/suggestTappingTopicScreenPage.dart';
import 'package:foodfreedomapp/screens/tappingScreen/tappingScreenPage.dart';
import 'package:foodfreedomapp/screens/webViewScreen/webViewScreenPage.dart';
import 'package:foodfreedomapp/services/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double width = size.width;
    double height = size.height;
    return Scaffold(
      appBar: appBarWithBackButton(context, "Settings", () {
        Navigator.pop(context);
      }),
      backgroundColor: strongCyan,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[vividCyan, darkCyan],
            ),
          ),
          child: Column(
            children: [
              settingsOptions(
                height,
                width,
                "accountsettings.png",
                "Account Settings",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AccountSettingsPage(),
                    ),
                  );
                },
              ),
              settingsOptions(
                height,
                width,
                "appsettings.png",
                "App Settings",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AppSettingsPage(),
                    ),
                  );
                },
              ),
              settingsOptions(
                height,
                width,
                "customizetapping.png",
                "Customize Tapping",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CustomizeTappingPage(
                        fromWhere: "Settings",
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: Divider(
                  color: white,
                  height: 1,
                ),
              ),
              settingsOptions(
                height,
                width,
                "suggest.png",
                "Suggest a Tapping Topic",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SuggestTappingTopicPage(),
                    ),
                  );
                },
              ),
              settingsOptions(
                height,
                width,
                "suggest.png",
                "Suggest an App Feature",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SuggestAppFeaturePage(),
                    ),
                  );
                },
              ),
              settingsOptions(
                height,
                width,
                "resources.png",
                "Resources",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResourcesPage(),
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: Divider(
                  color: white,
                  height: 1,
                ),
              ),
              settingsOptions(
                height,
                width,
                "report.png",
                "Report Problem",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReportAProblemPage(),
                    ),
                  );
                },
              ),
              settingsOptions(
                height,
                width,
                "privacy.png",
                "Privacy Policy",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                        link:
                            "https://www.jasonwinters.coach/privacy-policy-fft-app",
                        text: "Privacy Policy",
                      ),
                    ),
                  );
                },
              ),
              settingsOptions(
                height,
                width,
                "termsandcondition.png",
                "Terms & Conditions",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                        link:
                            "https://www.jasonwinters.coach/terms-conditions-fft-app",
                        text: "Terms & Conditions",
                      ),
                    ),
                  );
                },
              ),
              settingsOptions(
                height,
                width,
                "contactus.png",
                "Contact Us",
                context,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContactUsPage(),
                    ),
                  );
                },
              ),
              settingsOptions(
                height,
                width,
                "logout.png",
                "Logout",
                context,
                () async {
                  confirmDialogue(
                      context, "Log Out?", "Are you sure you want to Log Out?",
                      () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => IntroScreen(
                          initailPage: 2,
                        ),
                      ),
                    );
                    SharedPreferences prefs;
                    prefs = await SharedPreferences.getInstance();
                    prefs.setBool('loggedIn', false);
                    prefs.setString('checkInDone', 'false');
                    prefs.setStringList('userDetails', [
                      '',
                      '',
                      '',
                      '',
                      '',
                    ]);
                    checkDataFetchedActivity = false;
                    tappingDataFetchedActivity = false;
                    tappingDataFetched = false;
                    favoritesList.clear();
                    tappingActivityList.clear();
                    checkInList.clear();
                    downloadList.clear();
                    loremIpsumDolo1List.clear();
                    loremIpsumDolo2List.clear();
                    firstNameGlobal = '';
                    lastNameGlobal = '';
                    emailGlobal = '';
                    phoneNumberGlobal = '';
                    prefs.setString('favorites', "");
                  }, () {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
