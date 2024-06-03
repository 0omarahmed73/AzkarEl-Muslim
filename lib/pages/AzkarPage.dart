import 'package:azkar_new_app/components/zikr_item.dart';
import 'package:azkar_new_app/controller/azkarController.dart';
import 'package:azkar_new_app/controller/controller.dart';
import 'package:azkar_new_app/services/AllAzkar.dart';
import 'package:azkar_new_app/services/NightOrMorning.dart';
import 'package:azkar_new_app/services/copy_to_clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AzkarPage extends StatefulWidget {
  AzkarPage({super.key});
  static String id = 'AzkarPage';

  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  final AzkarController _zikrController = Get.put(AzkarController());

  @override
  Widget build(BuildContext context) {
    String type = ModalRoute.of(context)!.settings.arguments as String;
    final Controller c = Get.find<Controller>();
    final GetStorage storage = GetStorage();
    Map theme = storage.read('theme') == 'light'
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

    Map allAssets = {};
    if (type == 'أذكار الصباح') {
      allAssets = {
        'icon': Icon(Icons.sunny, color: theme['text1']),
        'azkar': NightOrMorning().morning
      };
    } else if (type == 'أذكار المساء') {
      allAssets = {
        'icon': Icon(Icons.nightlight, color: theme['text1']),
        'azkar': NightOrMorning().night
      };
    } else if (type == 'أذكار النوم') {
      allAssets = {
        'icon': Icon(Icons.bed, color: theme['text1']),
        'azkar': AllAzkar().sleep
      };
    } else if (type == 'أذكار الاستيقاظ من النوم') {
      allAssets = {
        'icon': Icon(Icons.bed, color: theme['text1']),
        'azkar': AllAzkar().wakeup
      };
    } else if (type == 'أذكار الذهاب الى المسجد') {
      allAssets = {
        'icon': Icon(Icons.mosque, color: theme['text1']),
        'azkar': AllAzkar().mosque
      };
    } else if (type == 'أذكار الأذان') {
      allAssets = {
        'icon': Icon(Icons.volume_up, color: theme['text1']),
        'azkar': AllAzkar().azan
      };
    } else if (type == 'سنن الجمعة') {
      allAssets = {
        'icon': Icon(Icons.people, color: theme['text1']),
        'azkar': AllAzkar().gomaaSunn
      };
    } else if (type == 'أذكار بعد الصلاة') {
      allAssets = {
        'icon': Icon(Icons.mosque, color: theme['text1']),
        'azkar': AllAzkar().afterPrayZekrList
      };
    } else if (type == 'أدعية قرآنية') {
      allAssets = {
        'icon': Icon(Icons.book, color: theme['text1']),
        'azkar': AllAzkar().quranDuaa
      };
    } else if (type == 'أدعية نبوية') {
      allAssets = {
        'icon': Icon(Icons.people, color: theme['text1']),
        'azkar': AllAzkar().sunaaDuaa
      };
    }

    _zikrController.initializeAzkarItems(allAssets['azkar']);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                type,
                style: TextStyle(
                    color: theme['text1'],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Almarai'),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0), child: allAssets['icon']),
            ],
          ),
          backgroundColor: theme['primary'],
          iconTheme: IconThemeData(color: theme['text1']),
        ),
        backgroundColor: theme['background'],
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Obx(() {
              if (_zikrController.azkarItems
                  .every((item) => item['repeat'] <= 0)) {
                return Center(
                  child: Container(
                    child: Text(
                      'تم الانتهاء بنجاح , جزاكم الله خيراً',
                      style: TextStyle(
                          color: theme['text2'],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Almarai'),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _zikrController.azkarItems.length,
                  itemBuilder: (context, index) {
                    return ZikrItem(
                      theme: theme,
                      azkarItem: _zikrController.azkarItems[index],
                      index: index,
                      zikrController: _zikrController,
                    );
                  },
                );
              }
            })));
  }
}
