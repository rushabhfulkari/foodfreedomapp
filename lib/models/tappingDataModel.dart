class TappingDataModel {
  final String tappingKey;
  final String audioLength;
  final String audioLink;
  final String authorImage;
  final String authorName;
  final String skipIntro;
  final List<BlinkingModel> blinkingModel;
  final String category;
  final String dateAdded;
  final String description;
  final String image;
  final List<RateIntensityModel> rateIntensity;
  final String title;

  TappingDataModel(
    this.tappingKey,
    this.audioLength,
    this.audioLink,
    this.authorImage,
    this.authorName,
    this.skipIntro,
    this.blinkingModel,
    this.category,
    this.dateAdded,
    this.description,
    this.image,
    this.rateIntensity,
    this.title,
  );
}

class BlinkingModel {
  final String begin;
  final String end;
  final String part;

  BlinkingModel(this.begin, this.end, this.part);
}

class RateIntensityModel {
  final String time;

  RateIntensityModel(
    this.time,
  );
}

List<TappingDataModel> favoritesList = [];
List<TappingDataModel> downloadList = [];
List<TappingDataModel> loremIpsumDolo1List = [];
List<TappingDataModel> loremIpsumDolo2List = [];
