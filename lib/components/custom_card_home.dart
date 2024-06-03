import 'package:flutter/material.dart';

class CustomCardHome extends StatelessWidget {
  const CustomCardHome({
    super.key,
    required this.theme,
    required this.child,
  });

  final Map theme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      color: theme['cardBg'],
      elevation: 5,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 30, top: 30, bottom: 10),
          child: child),
    );
  }
}
