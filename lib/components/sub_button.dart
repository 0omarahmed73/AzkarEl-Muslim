import 'package:azkar_new_app/pages/AzkarPage.dart';
import 'package:flutter/material.dart';

class SubButton extends StatelessWidget {
  const SubButton({
    super.key,
    required this.theme,
    required this.text,
    required this.newPath,
    this.azkar = true,
  });

  final Map theme;
  final String text;
  final String newPath;
  final bool azkar;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (azkar) {
            Navigator.of(context).pushNamed(AzkarPage.id, arguments: newPath);
          } else {
            Navigator.of(context).pushNamed(newPath);
          }
        },
        child: Card(
          elevation: 10,
          color: theme['primary'],
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Almarai',
                  fontSize: 17,
                  color: theme['text1']),
            ),
          ),
        ),
      ),
    );
  }
}
