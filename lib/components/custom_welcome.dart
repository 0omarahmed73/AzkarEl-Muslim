import 'package:azkar_new_app/services/copy_to_clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomWelcome extends StatelessWidget {
  const CustomWelcome(
      {super.key,
      required this.textColor,
      this.icon = true,
      this.quran = false,
      this.copy = true,
      required this.text1,
      required this.text2,
      this.onPress});
  final Color textColor;
  final String text1;
  final String text2;
  final bool quran;
  final bool icon;
  final bool copy;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text1,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: textColor,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Almarai'),
            ),
            Text(
              text2,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: !quran ? 'Almarai' : ''),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        icon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      if (copy) {
                        CopyService().copyToClipboardService(textColor, text2);
                      } else {
                        onPress!();
                      }
                    },
                    icon: !copy
                        ? Icon(Icons.arrow_circle_left)
                        : Icon(Icons.copy),
                    iconSize: !copy ? 40 : 25,
                    color: textColor,
                  ),
                ],
              )
            : Container()
      ],
    );
  }
}
