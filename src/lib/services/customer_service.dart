import 'package:m360_app_corpsec/helpers/mixins.dart';
import 'package:m360_app_corpsec/helpers/store.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/models/model.customer.dart';
import 'package:m360_app_corpsec/services/_webapi.dart';
import 'package:stacked/stacked.dart';

class CustomerService with ApiServiceMixin, ListenableServiceMixin {
  List<Customer> customerArr = [];

  CustomerService() ;

  // Future<Customer?> getCustomer(String id) async {
  //   Customer? c;
  //   try {
  //     final ar = await WebApi.callApi("GET", '/customers/$id');
  //     final d = ar.data;
  //     c = Customer.fromJson(d);
  //   } catch (e) {
  //     Utils.err("getCustomer : $e");
  //   }

  //   return c;
  // }

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
    }

    return l;
  }

}
