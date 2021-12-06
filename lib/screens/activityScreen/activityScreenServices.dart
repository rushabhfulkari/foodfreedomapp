import 'package:foodfreedomapp/models/checkInModel.dart';
import 'package:foodfreedomapp/models/tappingActivityDataModel.dart';

List getCheckInDataService(var tempList) {
  List<CheckInModel> addList = [];
  if (tempList != null) {
    tempList.forEach((keyCheckIn, valueCheckIn) {
      addList.add(CheckInModel(
        valueCheckIn['dateTime'].toString() != "null"
            ? valueCheckIn['dateTime'].toString()
            : "",
        valueCheckIn['howDoYouFeelRightNow'].toString() != "null"
            ? valueCheckIn['howDoYouFeelRightNow'].toString()
            : "",
        valueCheckIn['howIsYourDay'].toString() != "null"
            ? valueCheckIn['howIsYourDay'].toString()
            : "",
        valueCheckIn['iAlsoFeel'].toString() != "null"
            ? valueCheckIn['iAlsoFeel'].toString()
            : "",
        valueCheckIn['iAlsoFeelText'].toString() != "null"
            ? valueCheckIn['iAlsoFeelText'].toString()
            : "",
        valueCheckIn['thoughts'].toString() != "null"
            ? valueCheckIn['thoughts'].toString()
            : "",
        valueCheckIn['title'].toString() != "null"
            ? valueCheckIn['title'].toString()
            : "",
        valueCheckIn['whatMakesYouFeel'].toString() != "null"
            ? valueCheckIn['whatMakesYouFeel'].toString()
            : "",
      ));
    });
    List<CheckInModel> reversedList = new List.from(addList.reversed);
    return reversedList;
  }
  return [];
}

List getTappingActivityDataService(var tempList) {
  List<TappingActivityModel> addList = [];
  if (tempList != null) {
    tempList.forEach((keyTappingActivity, valueTappingActivity) {
      addList.add(TappingActivityModel(
        valueTappingActivity['audioLength'].toString() != "null"
            ? valueTappingActivity['audioLength'].toString()
            : "",
        valueTappingActivity['category'].toString() != "null"
            ? valueTappingActivity['category'].toString()
            : "",
        valueTappingActivity['dateTime'].toString() != "null"
            ? valueTappingActivity['dateTime'].toString()
            : "",
        valueTappingActivity['image'].toString() != "null"
            ? valueTappingActivity['image'].toString()
            : "",
        valueTappingActivity['status'].toString() != "null"
            ? valueTappingActivity['status'].toString()
            : "",
        valueTappingActivity['tappingKey'].toString() != "null"
            ? valueTappingActivity['tappingKey'].toString()
            : "",
        valueTappingActivity['title'].toString() != "null"
            ? valueTappingActivity['title'].toString()
            : "",
      ));
    });
    List<TappingActivityModel> reversedList = new List.from(addList.reversed);
    return reversedList;
  }
  return [];
}
