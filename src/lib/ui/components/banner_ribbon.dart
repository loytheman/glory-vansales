import 'package:flutter/material.dart';

class BannerRibbon extends StatelessWidget {
  const BannerRibbon({super.key, required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        color: Colors.pink,
        message: "Stage",
        location: BannerLocation.topStart,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12.0 * 0.85,
          fontWeight: FontWeight.w900,
          height: 1.0,
        ),
        child: child,
      ),
    );
  }
}
