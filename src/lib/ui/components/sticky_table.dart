import 'package:flutter/material.dart';

//final grey = Colors.grey.shade200;
const bgGrey = Color(0xFFEEEEEE);
const borderGrey = Color(0xFFD6D6D6);

class MyTableCell extends StatelessWidget {
  const MyTableCell.legendCell({
    super.key,
    required this.child,
    this.textStyle,
    this.colorBg = bgGrey,
    this.onTap,
  })  : _colorHorizontalBorder = bgGrey,
        _colorVerticalBorder = borderGrey;

  const MyTableCell.headerCell({
    super.key,
    required this.child,
    this.textStyle,
    this.colorBg = bgGrey,
    this.onTap,
  })  : _colorHorizontalBorder = bgGrey,
        _colorVerticalBorder = borderGrey;

  const MyTableCell.bodyCell({
    super.key,
    required this.child,
    this.textStyle,
    this.colorBg = Colors.transparent,
    this.onTap,
  })  : _colorHorizontalBorder = Colors.transparent,
        _colorVerticalBorder = borderGrey;

  const MyTableCell.stickyBodyCell({
    super.key,
    required this.child,
    this.textStyle,
    this.colorBg = Colors.transparent,
    this.onTap,
  })  : _colorHorizontalBorder = Colors.transparent,
        _colorVerticalBorder = borderGrey;

  //final CellDimensions cellDimensions;

  final Widget child;
  final Function()? onTap;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: _colorHorizontalBorder),
              right: BorderSide(color: _colorHorizontalBorder),
            ),
            color: colorBg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(alignment: Alignment.centerLeft, padding: EdgeInsets.zero, child: child),
            ),
            Container(
              height: 1.0,
              color: _colorVerticalBorder,
            ),
          ],
        ),
      ),
    );
  }
}
