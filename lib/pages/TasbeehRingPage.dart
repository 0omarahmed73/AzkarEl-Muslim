import 'package:azkar_new_app/controller/controller.dart';
import 'package:azkar_new_app/services/copy_to_clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TasbeehRingPage extends StatefulWidget {
  TasbeehRingPage({super.key});
  static String id = 'TasbeehRingPage';
  int count = 0;

  @override
  State<TasbeehRingPage> createState() => _TasbeehRingPageState();
}

class _TasbeehRingPageState extends State<TasbeehRingPage> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'خاتم التسبيح',
                style: TextStyle(
                    color: theme['text1'],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Almarai'),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.check_circle_outline_rounded)),
            ],
          ),
          backgroundColor: theme['primary'],
          iconTheme: IconThemeData(color: theme['text1']),
        ),
        backgroundColor: theme['background'],
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
                child: SingleChildScrollView(
              child: Card(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                elevation: 10,
                child: Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    color: theme['cardBg'],
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 185,
                        height: 120,
                        decoration: BoxDecoration(
                          color: theme['primary'],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          widget.count.toString(),
                          style: TextStyle(
                              color: theme['text1'],
                              fontSize: 40,
                              fontFamily: 'Orbitron'),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 25),
                            child: GestureDetector(
                              onTap: () {
                                widget.count = 0;
                                setState(() {});
                                print(widget.count);
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: theme['primary'],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.count++;
                          setState(() {});
                          print(widget.count);
                        },
                        child: Container(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: theme['primary'],
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))));
  }
}
