// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/models/model.customer.dart';

class wCustomerList extends StatelessWidget {
  final List<Customer> list;

  const wCustomerList({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> arr = [];

    for (var c in list) {
      final w = wCustomerCard(customer: c);
      arr.add(w);
    }

    final w = Column(children: arr);
    return w;
  }
}

class wCustomerCard extends StatelessWidget {
  final Customer customer;

  const wCustomerCard({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    Widget w = Container(
        padding: EdgeInsets.all(2.0),
        child: Column(
          children: [Icon(Icons.calendar_today_outlined, size: 16), Text(customer.displayName)],
        ));

    return w;
  }
}
