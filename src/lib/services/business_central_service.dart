import 'package:glory_vansales_app/helpers/mixins.dart';
import 'package:glory_vansales_app/helpers/store.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.customer.dart';
import 'package:glory_vansales_app/models/model.httpResponse.dart';
import 'package:glory_vansales_app/models/model.salesOrder.dart';
import 'package:glory_vansales_app/services/_webapi.dart';
import 'package:stacked/stacked.dart';

class BusinessCentralService with ApiServiceMixin, ListenableServiceMixin {
  List<Customer> customerArr = [];
  List<SalesOrder> SalesOrderArr = [];

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

  // GET {businesscentralPrefix}/companies({id})/SalesOrders({SalesOrderId})/SalesOrderLines

  Future<List<SalesOrder>> getAllPostedSalesOrder({FilterQuery? filter}) async {
    List<SalesOrder> l = [];
    String f = filter?.getString() ?? "";
    try {
      final ar = await WebApi.callApi("GET", '/SalesOrders$f');
      final d = ar.data;
      l = (List<SalesOrder>.from(d.map((x) => SalesOrder.fromJson(x))));
      SalesOrderArr = l;
    } catch (e) {
      // ShareFunc.showToast(e.toString());
      Utils.err("getAllSalesOrder : $e");
      rethrow;
    }

    return l;
  }

  Future<SalesOrder> getSalesOrderDetail(String id) async {
    SalesOrder? s;
    Utils.log("getSalesOrderDetail $id");
    try {
      final ar = await WebApi.callApi("GET", '/SalesOrders($id)?\$expand=SalesOrderLines,customer');
      // final ar = await WebApi.callApi("GET", '/SalesOrders(92afc879-7bd0-f011-8bce-6045bd74ddca)');
      final d = ar.data;
      s = SalesOrder.fromJson(d);
    } catch (e) {
      // ShareFunc.showToast(e.toString());
      Utils.err("getSalesOrderDetail : $e");
      rethrow;
    }

    return s;
  }
}
