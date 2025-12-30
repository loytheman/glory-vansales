import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:glory_vansales_app/common/theme.dart';

class wTag extends StatelessWidget {
  final String text;
  final VoidCallback? onTapFunc;
  const wTag({super.key, required this.text, this.onTapFunc});

  @override
  Widget build(BuildContext context) {
    final myStyle = Theme.of(context).extension<MyCustomStyle>();
    final s1 = context.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue.shade900);

    var w2 = Material(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.blue.shade100,
      child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          splashColor: Colors.blue.shade200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            // child: Text(text, style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
            child: Text(text.toUpperCase(), style: s1),
          ),
          onTap: onTapFunc),
    );
    return w2;
  }
}
