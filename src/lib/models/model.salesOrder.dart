import 'dart:ffi';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:glory_vansales_app/models/model.customer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SalesOrder {
  late String id;
  late String number;
  late String customerNumber;
  late String customerName;
  late String orderDate;
  late String shipToContact;
  late String shipToAddressLine1;
  late double totalAmountIncludingTax;

  Customer? customer;
  List<SalesOrderLine>? salesOrderLine_arr;

  SalesOrder();

  factory SalesOrder.fromMock() {
    final s = SalesOrder();
    s.number = BoneMock.chars(8, "-");
    s.customerNumber = BoneMock.chars(48, "-");
    s.customerName = BoneMock.chars(48, "-");
    s.orderDate = BoneMock.chars(48, "-");
    s.shipToContact = BoneMock.chars(48, "-");
    s.shipToAddressLine1 = BoneMock.chars(48, "-");
    s.totalAmountIncludingTax = 1000.0;
    return s;
  }

  factory SalesOrder.fromJson(Map<String, dynamic> json) {
    final s = SalesOrder();
    final d = json;

    s.id = d["id"];
    s.number = d["number"];
    s.customerNumber = d["customerNumber"];
    s.customerName = d["customerName"];
    s.orderDate = d["orderDate"];
    s.shipToContact = d["shipToContact"];
    s.shipToAddressLine1 = d["shipToAddressLine1"];
    s.totalAmountIncludingTax = d["totalAmountIncludingTax"].toDouble();

    if (d['customer'] != null) {
      s.customer = Customer.fromJson(d['customer']);
    }

    final arr = d['salesOrderLines'];
    if (arr != null) {
      s.salesOrderLine_arr = (List<SalesOrderLine>.from(arr.map((x) => SalesOrderLine.fromJson(x))));
    }

    return s;
  }
  @override
  String toString() {
    return "\n> SalesOrder: ($id, $customerName)";
  }
}

enum LineType { item, comment }

class SalesOrderLine {
  late String id;
  late String itemId;
  late LineType lineType;
  late String lineObjectNumber;
  late String description;
  late String unitOfMeasureCode;
  late double quantity;
  late double unitPrice;
  late double discountPercent;
  late double amountExcludingTax;
  late double netAmountIncludingTax;

  Customer? customer;
  List<SalesOrderLine>? salesOrderLine_arr;

  SalesOrderLine();

  factory SalesOrderLine.fromMock() {
    final s = SalesOrderLine();

    return s;
  }
  factory SalesOrderLine.fromJson(Map<String, dynamic> json) {
    final s = SalesOrderLine();
    final d = json;

    s.id = d["id"];
    s.itemId = d["itemId"];
    s.lineType = d["lineType"] == "Item" ? LineType.item : LineType.comment;
    s.lineObjectNumber = d['lineObjectNumber'];
    s.description = d['description'];
    s.unitOfMeasureCode = d['unitOfMeasureCode'];
    s.quantity = d['quantity'].toDouble();
    s.unitPrice = d['unitPrice'].toDouble();
    s.discountPercent = d['discountPercent'].toDouble();
    s.amountExcludingTax = d['amountExcludingTax'].toDouble();
    s.netAmountIncludingTax = d['netAmountIncludingTax'].toDouble();

    return s;
  }

  @override
  String toString() {
    return "\n> SalesOrderLine: ($id, $description)";
  }
}
