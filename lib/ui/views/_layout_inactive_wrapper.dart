import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/helpers/life_cycle.dart';
import 'package:stacked/stacked_annotations.dart';

class LifeCycleBlurWrapper extends StatefulWidget {
  final Widget child;
  const LifeCycleBlurWrapper({Key? key, required this.child}) : super(key: key);

  @override
  LifeCycleBlurWrapperState createState() => LifeCycleBlurWrapperState();
}

class LifeCycleBlurWrapperState extends State<LifeCycleBlurWrapper>
    with WidgetsBindingObserver {
  bool _isInactive = false;
  String? _scopeName;

  @override
  void initState() {
    print('run here wrapper init stat..? ${LifeCycleHelper.scopeName}');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("app state: ${state}");
    setState(() {
      // When the app state is inactive, set _isInactive to true.
      _isInactive = state == AppLifecycleState.inactive;
    });
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    // print('run dispose in lifecycle wrapper ${LifeCycleHelper.scopeName}', );
    // if (_scopeName != null) {
    //   try {
    //     print('runpopscope wrapper');
    //     await StackedLocator.instance.popScope();
    //     _scopeName = null;
    //   } catch (e) {
    //     print(e);
    //   }
    // } 
    // _scopeName = LifeCycleHelper.scopeName;
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
