import 'package:get/get.dart';

class AzkarController extends GetxController {
  var azkarItems = <Map>[].obs;

  void initializeAzkarItems(List<Map> items) {
    azkarItems.assignAll(items.map((item) => Map.from(item)).toList());
    print('Azkar items initialized: $azkarItems'); // Debug statement
  }

  void decrementRepeat(int index) {
    if (azkarItems[index]['repeat'] > 0) {
      azkarItems[index]['repeat']--;
      azkarItems[index] =
          Map.from(azkarItems[index]); // Trigger reactive update
      print(
          'Decremented repeat at index $index: ${azkarItems[index]['repeat']}'); // Debug statement
    }
  }
}
