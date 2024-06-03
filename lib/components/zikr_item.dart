import 'package:azkar_new_app/controller/azkarController.dart';
import 'package:azkar_new_app/services/copy_to_clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azkar_new_app/controller/azkarController.dart';
import 'package:azkar_new_app/services/copy_to_clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZikrItem extends StatelessWidget {
  ZikrItem({
    super.key,
    required this.theme,
    required this.azkarItem,
    required this.index,
    required this.zikrController,
  });

  final Map theme;
  final Map azkarItem;
  final int index;
  final AzkarController zikrController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedCrossFade(
        duration: Duration(milliseconds: 300),
        firstChild: zikrController.azkarItems[index]['repeat'] > 0
            ? Column(children: [
                GestureDetector(
                  onTap: () {
                    zikrController.decrementRepeat(index);
                  },
                  child: Card(
                      color: theme['cardBg'],
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            left: 20, right: 30, top: 20, bottom: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  azkarItem['zekr'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: theme['text2'],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 2.1,
                                      fontFamily: 'Almarai'),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
                Transform.translate(
                    offset: Offset(0, -30), // Adjusted to half of the margin
                    child: Card(
                        elevation: 5,
                        color: theme['primary'],
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  CopyService().copyToClipboardService(
                                      theme['text2'], azkarItem['zekr']);
                                },
                                icon: Icon(Icons.copy),
                                iconSize: 25,
                                color: theme['text1'],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    zikrController.azkarItems[index]['repeat']
                                        .toString(),
                                    style: TextStyle(
                                      color: theme['text1'],
                                      fontFamily: 'Almarai',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '|',
                                    style: TextStyle(
                                      color: theme['text1'],
                                      fontFamily: 'Almarai',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'التكرار',
                                    style: TextStyle(
                                      color: theme['text1'],
                                      fontFamily: 'Almarai',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )))
              ])
            : Container(),
        secondChild: Container(),
        crossFadeState: zikrController.azkarItems[index]['repeat'] > 0
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      );
    });
  }
}
