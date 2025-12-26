import 'package:skeletonizer/skeletonizer.dart';

class Customer {
  late String? id;
  late String? displayName;

  Customer();

  factory Customer.fromMock() {
    final c = Customer();
    c.displayName = BoneMock.chars(48, "-");
    return c;
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    final c = Customer();
    final d = json;

    c.id = d["id"];
    c.displayName = d["displayName"];

    return c;
  }
  @override
  String toString() {
    return "\n> Company: ($id, $displayName)";
  }
}

