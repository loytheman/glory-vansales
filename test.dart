import 'package:get_it/get_it.dart';

void main() {
  // two separate GetIt containers:
  final getIt1 = GetIt.asNewInstance();
  final getIt2 = GetIt.asNewInstance();

  // now you can register different services in each:
  getIt1.registerSingleton<MyService>(MyService(), instanceName: 'one');
  getIt2.registerSingleton<MyService>(MyService(), instanceName: 'two');

  // retrieving:
  var svc1 = getIt1<MyService>(instanceName: 'one');
  var svc2 = getIt2<MyService>(instanceName: 'two');

  print(identical(svc1, svc2)); // false
}

class MyService {
}