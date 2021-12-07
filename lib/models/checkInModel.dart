class CheckInModel {
  final String dateTime;
  final String howDoYouFeelRightNow;
  final String howIsYourDay;
  final String iAlsoFeel;
  final String iAlsoFeelText;
  final String thoughts;
  final String title;
  final String whatMakesYouFeel;

  CheckInModel(
      this.dateTime,
      this.howDoYouFeelRightNow,
      this.howIsYourDay,
      this.iAlsoFeel,
      this.iAlsoFeelText,
      this.thoughts,
      this.title,
      this.whatMakesYouFeel);
}

var checkInList = [];
var checkInListWeeklySnapshot = [];
