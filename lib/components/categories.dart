import 'package:azkar_new_app/components/sub_button.dart';
import 'package:azkar_new_app/pages/TasbeehRingPage.dart';
import 'package:azkar_new_app/pages/ThankingAllahPage.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.theme,
  });

  final Map theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SubButton(
              theme: theme,
              text: 'أذكار المساء',
              newPath: 'أذكار المساء',
            ),
            SubButton(
              theme: theme,
              text: 'أذكار الصباح',
              newPath: 'أذكار الصباح',
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SubButton(
              theme: theme,
              text: 'خاتم التسبيح',
              newPath: TasbeehRingPage.id,
              azkar: false,
            ),
            SubButton(
              theme: theme,
              text: 'شكر النعم',
              newPath: ThankingAllahPage.id,
              azkar: false,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
