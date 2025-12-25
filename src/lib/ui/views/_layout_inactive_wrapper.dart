import 'dart:ui';

import 'package:flutter/material.dart';

class LifeCycleBlurWrapper extends StatefulWidget {
  final Widget child;
  const LifeCycleBlurWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _LifeCycleBlurWrapperState createState() => _LifeCycleBlurWrapperState();
}

class _LifeCycleBlurWrapperState extends State<LifeCycleBlurWrapper> with WidgetsBindingObserver {
  bool _isInactive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      // When the app state is inactive, set _isInactive to true.
      _isInactive = state == AppLifecycleState.inactive;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isInactive)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),
      ],
    );
  }
}
