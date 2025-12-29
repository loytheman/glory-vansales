import 'dart:async';
import 'package:glory_vansales_app/common/constants.dart';
import 'package:stacked/stacked.dart';

mixin FormMixin on FormViewModel {
  //{email: Please enter email, password: Please enter password};
  bool formCheckHasError(Map<String, String?> validationMessages) {
    var m = validationMessages;
    for (String key in m.keys) {
      String v = m[key] ??= "";
      if (v.isNotEmpty) {
        return true;
      }
    }
    return false;
  }
}

mixin ApiServiceMixin {
  bool isBusy = false;

  void setBusy(bool flag) {
    isBusy = flag;
  }
}

mixin EventChildWidgetMixin on BaseViewModel {
  List<StreamSubscription> eventSubscriptions = [];

  void addEventSubscription(StreamSubscription es) {
    eventSubscriptions.add(es);
    //es?.cancel();
  }

  void removeEventSubscriptions() {
    eventSubscriptions.map((e) => e.cancel());
  }
}

class ChildWidgetEvent {
  String name = EventType.NONE;
  Object? data = {};
  ChildWidgetEvent({required this.name, this.data});
}
