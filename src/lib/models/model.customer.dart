import 'package:skeletonizer/skeletonizer.dart';

class Customer {
  late String id;
  late String displayName;
  late String email;
  late String phoneNumber;
  late String addressLine1;
  late String addressLine2;
  late String postalCode;

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
    c.email = d["email"];
    c.phoneNumber = d["phoneNumber"];
    c.addressLine1 = d["addressLine1"];
    c.addressLine2 = d["addressLine2"];
    c.postalCode = d["postalCode"];

    return c;
  }
  @override
  String toString() {
    return "\n> Company: ($id, $displayName)";
  }
}
