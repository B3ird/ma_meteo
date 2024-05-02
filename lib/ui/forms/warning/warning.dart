import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ma_meteo/ui/common/app_colors.dart';

class Warning extends StatefulWidget {
  final String text;
  final String? iconPath;

  const Warning({
    Key? key,
    required this.text,
    this.iconPath,
  }) : super(key: key);

  @override
  State<Warning> createState() => DarkWarningState();
}

class DarkWarningState extends State<Warning> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (widget.iconPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(
                  widget.iconPath!,
                  colorFilter:
                      const ColorFilter.mode(kcWineRed, BlendMode.srcIn),
                ),
              ),
            Flexible(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: kcWineRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
