import 'package:share/share.dart';

Future<void> share(text) async {
  await Share.share("$text");
}
