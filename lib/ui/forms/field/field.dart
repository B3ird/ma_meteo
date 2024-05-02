import 'dart:io';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_colors.dart';

class FieldWidget extends StatefulWidget {
  final String? hintText;
  final String? defaultText;
  final String? errorText;
  final String? iconPath;
  final bool obscureText;
  final bool enabled;
  final String? tooltip;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool capitalize;
  final bool last;

  const FieldWidget(
      {Key? key,
      @required this.hintText,
      this.defaultText,
      this.errorText,
      this.tooltip,
      this.iconPath,
      this.inputType,
      this.obscureText = false,
      this.enabled = true,
      this.controller,
      this.capitalize = false,
      this.last = false})
      : super(key: key);

  @override
  _FieldWidgetState createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  TextEditingController? _controller;
  bool hidden = false;

  @override
  void initState() {
    hidden = widget.obscureText;
    if (widget.controller != null) {
      _controller = widget.controller;
      if (widget.defaultText != null) {
        _controller?.text = widget.defaultText!;
      }
    } else {
      _controller = TextEditingController(text: widget.defaultText);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            textInputAction:
                widget.last ? TextInputAction.done : TextInputAction.next,
            textCapitalization: widget.capitalize
                ? TextCapitalization.sentences
                : TextCapitalization.none,
            controller: _controller,
            style: widget.enabled
                ? const TextStyle(
                    color: kcNight,
                    fontWeight: FontWeight.w600,
                  )
                : const TextStyle(
                    color: kcNight,
                    fontWeight: FontWeight.w200,
                  ),
            // initialValue: widget.defaultText, //can't use initialValue and controller at the same time
            obscureText: hidden,
            enabled: widget.enabled,
            // TextInputType.name doesn't support auto-capitalization on iOS
            keyboardType: Platform.isIOS &&
                    widget.capitalize &&
                    widget.inputType == TextInputType.name
                ? null
                : widget.inputType,
            cursorColor: kcPrimaryColor,
            decoration: InputDecoration(
              errorText: widget.errorText,
              errorStyle: const TextStyle(
                color: kcLightWineRed,
                fontWeight: FontWeight.w600,
              ),
              fillColor: kcSnow,
              filled: true,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: kcPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: kcDarkGreyColor),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: kcNight),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 32, color: kcWineRed),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: kcWineRed),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              prefixIcon: widget.iconPath != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 16,
                        top: 16,
                        bottom: 16,
                        end: 8,
                      ),
                      child: widget.enabled
                          ? SvgPicture.asset(
                              widget.iconPath!,
                              colorFilter: const ColorFilter.mode(
                                  kcPrimaryColor, BlendMode.srcIn),
                            )
                          : SvgPicture.asset(
                              widget.iconPath!,
                              colorFilter: const ColorFilter.mode(
                                  kcPrimaryColor, BlendMode.srcIn),
                            ),
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                  color: kcPrimaryColorDark,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200),
            ),
          ),
          if (widget.obscureText)
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: toggleEye,
                child: const Icon(
                  Icons.remove_red_eye,
                  color: kcIce,
                ),
              ),
            ),
        ],
      ),
      if (widget.tooltip != null)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            widget.tooltip!,
            style: const TextStyle(
              color: kcCloud,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
    ]);
  }

  void toggleEye() {
    setState(() {
      hidden = !hidden;
    });
  }
}
