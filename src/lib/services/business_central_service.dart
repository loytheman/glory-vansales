import 'package:m360_app_corpsec/helpers/mixins.dart';
import 'package:m360_app_corpsec/helpers/store.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.customer.dart';
import 'package:m360_app_corpsec/models/model.salesInvoice.dart';
import 'package:m360_app_corpsec/services/_webapi.dart';
import 'package:stacked/stacked.dart';

class BusinessCentralService with ApiServiceMixin, ListenableServiceMixin {
  List<Customer> customerArr = [];
  List<SalesInvoice> salesInvoiceArr = [];

  BusinessCentralService();

  Future<List<Customer>> getAllCustomers() async {
    List<Customer> l = [];
    try {
      final ar = await WebApi.callApi("GET", '/customers');
      final d = ar.data;
      l = (List<Customer>.from(d.map((x) => Customer.fromJson(x))));
      customerArr = l;
    } catch (e) {
      // ShareFunc.showToast(e.toString());
      Utils.err("getAllCustomer : $e");
      rethrow;
    }

    return l;
  }

  // GET {businesscentralPrefix}/companies({id})/salesInvoices({salesInvoiceId})/salesInvoiceLines

  Future<List<SalesInvoice>> getAllPostedSalesInvoice() async {
    List<SalesInvoice> l = [];
    try {
      final ar = await WebApi.callApi("GET", '/salesInvoices');
      final d = ar.data;
      l = (List<SalesInvoice>.from(d.map((x) => SalesInvoice.fromJson(x))));
      salesInvoiceArr = l;
    } catch (e) {
      // ShareFunc.showToast(e.toString());
      Utils.err("getAllSalesInvoice : $e");
      rethrow;
    }

    return l;
  }

  Future<SalesInvoice> getSalesInvoiceDetail(String id) async {
    SalesInvoice? s;
    Utils.log("getSalesInvoiceDetail $id");
    try {
      final ar = await WebApi.callApi("GET", '/salesInvoices($id)?\$expand=salesInvoiceLines,customer');
      // final ar = await WebApi.callApi("GET", '/salesInvoices(92afc879-7bd0-f011-8bce-6045bd74ddca)');
      final d = ar.data;
      s = SalesInvoice.fromJson(d);
    } catch (e) {
      // ShareFunc.showToast(e.toString());
      Utils.err("getSalesInvoiceDetail : $e");
      rethrow;
    }

    return s;
  }
}
