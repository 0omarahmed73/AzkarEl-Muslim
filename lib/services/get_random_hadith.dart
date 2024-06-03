import 'dart:math';

import 'package:hadith/hadith.dart';

String getRandomHadith() {
  Random random = Random();
  int randomNumber = random.nextInt(30) + 1;
  var hadith = getHadith(Collections.bukhari, randomNumber, 1);
  String hadithData = hadith.hadith[1].body;
  return hadithData;
}
