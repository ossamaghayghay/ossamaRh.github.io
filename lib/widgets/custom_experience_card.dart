import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../settings/app_setting.dart';

class CustomExperienceCard extends StatefulWidget {
  final title;
  final fromData;
  final toData;
  final description;
  final children;
  const CustomExperienceCard({
    super.key,
    required this.title,
    required this.children,
    required this.fromData,
    required this.toData,
    required this.description,
  });

  @override
  State<CustomExperienceCard> createState() => _CustomExperienceCardState();
}

class _CustomExperienceCardState extends State<CustomExperienceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (hovering) {
        setState(() {
          isHovered = hovering;
        });
      },
      onTap: () {
        // TODO
      },
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: isHovered
              ? Color(0xFF17264B).withOpacity(0.5)
              : Color(0xFF17264B),
          borderRadius: BorderRadius.circular(8),
        ),
        // width: 600,
        // height: 1000,
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  child: Text(
                    widget.fromData,
                    style: TextStyle(
                      fontFamily: AppSettings.fontF,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
                Gap(5),
                Container(
                  color: Color(0xFF94A3B8),
                  width: 12,
                  height: 1,
                ),
                Gap(5),
                Container(
                  child: Text(
                    widget.toData,
                    style: TextStyle(
                      fontFamily: AppSettings.fontF,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ],
            ),
            Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: AppSettings.fontF,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Gap(10),
                Container(
                  width: 400,
                  child: Text(
                   widget.description,
                    style: TextStyle(
                      fontFamily: AppSettings.fontF,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
                Gap(10),
                Wrap(
                  children: widget.children,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
