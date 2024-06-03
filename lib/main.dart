import 'package:azkar_new_app/controller/controller.dart';
import 'package:azkar_new_app/models/bless_model.dart';
import 'package:azkar_new_app/pages/AboutUsPage.dart';
import 'package:azkar_new_app/pages/AzkarPage.dart';
import 'package:azkar_new_app/pages/HomePage.dart';
import 'package:azkar_new_app/pages/TasbeehRingPage.dart';
import 'package:azkar_new_app/pages/ThankingAllahPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init(); // Initialize get_storage
  final GetStorage storage = GetStorage();

  List<BlessModel> defaultBlesses = [
    BlessModel(name: "سمعي", done: false, id: 0),
    BlessModel(name: "بصري", done: false, id: 1),
    BlessModel(name: "لساني", done: false, id: 2),
    BlessModel(name: "ديني", done: false, id: 3),
    BlessModel(name: "أهلي", done: false, id: 4),
    BlessModel(name: "العلم", done: false, id: 5),
    BlessModel(name: "الإسلام", done: false, id: 6),
    BlessModel(name: "الهداية", done: false, id: 7),
  ];

  // Check if 'blesses' data exists in storage
  if (!storage.hasData('blesses')) {
    // Save the default blesses to storage
    storage.write('blesses', defaultBlesses.map((e) => e.toJson()).toList());
  }

  // Read the 'blesses' data from storage
  final dynamic storedData = storage.read('blesses');

  // Example usage
  runApp(const AzkarApp());
}

class AzkarApp extends StatelessWidget {
  const AzkarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    Map<String, dynamic> theme = controller.mode.value == 'light'
        ? {
            'primary': Colors.deepPurple,
            'text1': Colors.white,
            'iconMode': Icon(Icons.sunny),
            'background': Colors.white,
            'cardBg': Color.fromRGBO(250, 243, 255, 1),
            'text2': Colors.black,
            'button1': Color.fromRGBO(45, 175, 240, 1)
          }
        : {
            'primary': Color.fromRGBO(255, 195, 0, 1),
            'text1': Colors.black,
            'iconMode': Icon(Icons.nights_stay),
            'background': Color.fromRGBO(0, 29, 61, 1),
            'cardBg': Color.fromRGBO(31, 57, 96, 1),
            'text2': Colors.white,
            'button1': Color.fromRGBO(255, 195, 0, 1)
          };

    return GetMaterialApp(
      routes: {
        HomePage.id: (context) => HomePage(),
        AzkarPage.id: (context) => AzkarPage(),
        TasbeehRingPage.id: (context) => TasbeehRingPage(),
        ThankingAllahPage.id: (context) => ThankingAllahPage(),
        AboutUsPage.id: (context) => AboutUsPage(
              theme: theme,
            ),
      },
      initialRoute: HomePage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
