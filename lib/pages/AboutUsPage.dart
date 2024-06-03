import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  static String id = 'AboutUsPage';
  final Map<String, dynamic> theme;

  AboutUsPage({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme['background'],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تم تصميم هذا التطبيق كصدقة جارية عن جميع اموات المسلمين',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 24,
                  color: theme['text2'],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'تقبل الله منا ومنكم وجزاكم الله خيراً',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 24,
                  color: theme['text2'],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
