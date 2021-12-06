import 'package:foodfreedomapp/models/tappingDataModel.dart';

TappingDataModel tappingDataServices(valueTapping, tappingKey) {
  TappingDataModel temp;
  temp = TappingDataModel(
    '$tappingKey',
    '${valueTapping['audioLength']}'.toString(),
    '${valueTapping['audioLink']}'.toString(),
    '${valueTapping['authorImage']}'.toString(),
    '${valueTapping['authorName']}'.toString(),
    '${valueTapping['skipIntro']}'.toString(),
    returnListBlinkingData(valueTapping['blinking']),
    '${valueTapping['category']}'.toString(),
    '${valueTapping['dateAdded']}'.toString(),
    '${valueTapping['description']}'.toString(),
    '${valueTapping['image']}'.toString(),
    returnListRateIntensityData(valueTapping['rateIntensity']),
    '${valueTapping['title']}'.toString(),
  );
  return temp;
}

List<BlinkingModel> returnListBlinkingData(blinkingData) {
  List<BlinkingModel> tempList = [];
  blinkingData.forEach((blinkingKey, blinkingValue) {
    tempList.add(BlinkingModel(
      blinkingValue['begin'].toString(),
      blinkingValue['end'].toString(),
      blinkingValue['part'].toString(),
    ));
  });
  return tempList;
}

List<RateIntensityModel> returnListRateIntensityData(rateIntensityData) {
  List<RateIntensityModel> tempList = [];
  rateIntensityData.forEach((rateIntensityKey, rateIntensityValue) {
    tempList.add(RateIntensityModel(
      rateIntensityValue['time'].toString(),
    ));
  });
  return tempList;
}
