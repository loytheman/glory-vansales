import 'dart:async';
import 'dart:ui';

class LifeCycleHelper {
  static late StreamController _controller;

  static init() async {
    _controller = StreamController.broadcast();
  }

  static void addStream(AppLifecycleState state) {
    if (!_controller.isClosed) {
      _controller.add(state);
    }
  }

  static void addStreamEvent(String eventType) {
    if (!_controller.isClosed) {
      _controller.add(eventType);
    }
  }

  static Stream getStream() {
    return _controller.stream;
  }

  static Future<void> closeStream() {
    return _controller.close();
  }
}
