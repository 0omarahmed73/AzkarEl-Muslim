import 'dart:math';
import 'package:azkar_new_app/components/categories.dart';
import 'package:azkar_new_app/components/custom_card_home.dart';
import 'package:azkar_new_app/components/custom_welcome.dart';
import 'package:azkar_new_app/controller/controller.dart';
import 'package:azkar_new_app/models/bless_model.dart';
import 'package:azkar_new_app/pages/AboutUsPage.dart';
import 'package:azkar_new_app/pages/AzkarPage.dart';
import 'package:azkar_new_app/pages/AzkarCategoriesPage.dart'; // Import AzkarCategoriesPage
import 'package:azkar_new_app/pages/PrayersPage.dart'; // Import PrayersPage
import 'package:azkar_new_app/services/get_random_hadith.dart';
import 'package:azkar_new_app/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran/quran.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller controller = Get.put(Controller());

  // Variable to track which page is currently displayed
  int currentPageIndex = 3; // Default to HomeScreen

  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  void setPageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      builder: (controller) {
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

        Widget body;
        switch (currentPageIndex) {
          case 0:
            body = AboutUsPage(theme: theme);
            break;
          case 1:
            body = PrayersPage(theme: theme);
            break;
          case 2:
            body = AzkarCategoriesPage(theme: theme);
            break;
          case 3:
            body = HomeScreen(theme: theme, setPageIndex: setPageIndex);
            break;
          default:
            body = HomeScreen(theme: theme, setPageIndex: setPageIndex);
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    controller.toggleMode();
                    setState(() {});
                  },
                  icon: Obx(() {
                    return controller.mode.value == 'light'
                        ? Icon(Icons.sunny)
                        : Icon(Icons.nights_stay);
                  }),
                  color: theme['text1'],
                ),
                Row(
                  children: [
                    Text(
                      'أذكار المسلم',
                      style: TextStyle(
                          color: theme['text1'],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Almarai'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.mode_night,
                        color: theme['text1'],
                      ),
                    ),
                  ],
                )
              ],
            ),
            backgroundColor: theme['primary'],
          ),
          backgroundColor: theme['background'],
          body: body,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType
                .fixed, // Ensure icons are always visible
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'عنا',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mosque),
                label: 'الدعاء',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'الأذكار',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
            ],
            currentIndex: currentPageIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            selectedLabelStyle:
                TextStyle(color: Theme.of(context).primaryColor),
            unselectedLabelStyle: TextStyle(
              color: Colors.transparent, // Hide unselected labels
            ),
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> theme;
  final Function(int) setPageIndex;

  HomeScreen({required this.theme, required this.setPageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      builder: (controller) {
        String hadithData = getRandomHadith();
        DateTime now = DateTime.now();
        String text2 = now.hour >= 4 && now.hour <= 16
            ? 'ابدا يومك بقراءة اذكار الصباح'
            : 'ابدا ليلتك بقراءة اذكار المساء';
        String arguments =
            now.hour >= 4 && now.hour <= 16 ? 'أذكار الصباح' : 'أذكار المساء';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView(
            children: [
              CustomCardHome(
                theme: widget.theme,
                child: CustomWelcome(
                    text1: 'السلام عليكم ورحمة الله وبركاته',
                    text2: text2,
                    textColor: widget.theme['text2'],
                    copy: false,
                    onPress: () {
                      Navigator.pushNamed(context, AzkarPage.id,
                          arguments: arguments);
                    }),
              ),
              CustomCardHome(
                  theme: widget.theme,
                  child: Column(
                    children: [
                      Categories(theme: widget.theme),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                widget.setPageIndex(
                                    2); // Set index to 2 when clicked
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10, left: 5),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: widget.theme['primary'],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: widget.theme['text1'],
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
              CustomCardHome(
                theme: widget.theme,
                child: CustomWelcome(
                  text1: 'تذكير',
                  text2:
                      'يا غُلامُ إنِّي أعلِّمُكَ كلِماتٍ ، احفَظِ اللَّهَ يحفَظكَ ، احفَظِ اللَّهَ تَجِدْهُ تجاهَكَ ، إذا سأَلتَ فاسألِ اللَّهَ ، وإذا استعَنتَ فاستَعِن باللَّهِ ، واعلَم أنَّ الأمَّةَ لو اجتَمعت علَى أن ينفَعوكَ بشَيءٍ لم يَنفعوكَ إلَّا بشيءٍ قد كتبَهُ اللَّهُ لَكَ ، ولو اجتَمَعوا على أن يضرُّوكَ بشَيءٍ لم يَضرُّوكَ إلَّا بشَيءٍ قد كتبَهُ اللَّهُ عليكَ ، رُفِعَتِ الأقلامُ وجفَّتِ الصُّحفُ',
                  textColor: widget.theme['text2'],
                  icon: true,
                  copy: true,
                ),
              ),
              CustomCardHome(
                theme: widget.theme,
                child: CustomWelcome(
                  text1: 'آية اليوم',
                  text2: '${RandomVerse().verse}',
                  textColor: widget.theme['text2'],
                  quran: true,
                ),
              ),
              CustomCardHome(
                theme: widget.theme,
                child: CustomWelcome(
                  text1: 'حديث اليوم',
                  text2:
                      hadithData.replaceAll('<p>', '').replaceAll('</p>', ''),
                  textColor: widget.theme['text2'],
                  quran: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
