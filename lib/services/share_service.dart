import 'dart:ui';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:stacked/stacked.dart';

class ShareService with ListenableServiceMixin {
  ShareService() {
    listenToReactiveValues([_postCount]);
  }

  int _postCount = 0;
  int get postCount => _postCount;
  VoidCallback? onFunc;

  void callChild() {
    Utils.log("Call Child");
  }

  void callParent() {
    Utils.log("Call Parent");
  }

  void updatePostCount() {
    //ShareFunc.showToast("updatePostCount = $postCount");
    //_postCount++;
    notifyListeners();
  }

  void resetCount() {
    _postCount = 0;
    notifyListeners();
  }
}
