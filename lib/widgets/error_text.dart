import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText(this.error, {super.key, this.style, this.textAlign});

  final String error;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    TextStyle errorStyle = TextStyle(color: errorColor);
    if (style != null) {
      errorStyle = style!.copyWith(color: errorColor);
    }

    return SelectableText(error, style: errorStyle, textAlign: textAlign);
  }
}
