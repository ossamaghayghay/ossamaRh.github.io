import 'package:flutter/material.dart';
import 'package:my_portfolio/settings/app_setting.dart';

class CardTag extends StatelessWidget {
  final String tag;
  const CardTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFF183656),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Color(0xFF4EC0C6),
          fontFamily: AppSettings.fontF,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
