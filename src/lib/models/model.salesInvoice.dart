import 'dart:ffi';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:glory_vansales_app/models/model.customer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SalesInvoice {
  late String id;
  late String number;
  late String customerNumber;
  late String customerName;
  late String invoiceDate;
  late String shipToContact;
  late String shipToAddressLine1;
  late double totalAmountIncludingTax;

  Customer? customer;
  List<SalesInvoiceLine>? salesInvoiceLine_arr;

  SalesInvoice();

  factory SalesInvoice.fromMock() {
    final s = SalesInvoice();
    s.number = BoneMock.chars(8, "-");
    s.customerNumber = BoneMock.chars(48, "-");
    s.customerName = BoneMock.chars(48, "-");
    s.invoiceDate = BoneMock.chars(48, "-");
    s.shipToContact = BoneMock.chars(48, "-");
    s.shipToAddressLine1 = BoneMock.chars(48, "-");
    s.totalAmountIncludingTax = 1000.0;
    return s;
  }

  factory SalesInvoice.fromJson(Map<String, dynamic> json) {
    final s = SalesInvoice();
    final d = json;

    s.id = d["id"];
    s.number = d["number"];
    s.customerNumber = d["customerNumber"];
    s.customerName = d["customerName"];
    s.invoiceDate = d["invoiceDate"];
    s.shipToContact = d["shipToContact"];
    s.shipToAddressLine1 = d["shipToAddressLine1"];
    s.totalAmountIncludingTax = d["totalAmountIncludingTax"].toDouble();

    if (d['customer'] != null) {
      s.customer = Customer.fromJson(d['customer']);
    }

    final arr = d['salesInvoiceLines'];
    if (arr != null) {
      s.salesInvoiceLine_arr = (List<SalesInvoiceLine>.from(arr.map((x) => SalesInvoiceLine.fromJson(x))));
    }

    return s;
  }
  @override
  String toString() {
    return "\n> SalesInvoice: ($id, $customerName)";
  }
}

enum LineType { item, comment }

class SalesInvoiceLine {
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
  List<SalesInvoiceLine>? salesInvoiceLine_arr;

  SalesInvoiceLine();

  factory SalesInvoiceLine.fromMock() {
    final s = SalesInvoiceLine();

    return s;
  }
  factory SalesInvoiceLine.fromJson(Map<String, dynamic> json) {
    final s = SalesInvoiceLine();
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
    return "\n> SalesInvoiceLine: ($id, $description)";
  }
}
