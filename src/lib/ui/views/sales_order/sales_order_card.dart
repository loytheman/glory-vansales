// ignore_for_file: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.salesOrder.dart';
import 'package:skeletonizer/skeletonizer.dart';

class wSalesOrderList extends StatelessWidget {
  final List<SalesOrder> list;
  final void Function(SalesOrder s)? onTapFunc;

  const wSalesOrderList({super.key, required this.list, this.onTapFunc});

  factory wSalesOrderList.createContentFunc(List<dynamic> list, Function(dynamic s)? onTapFunc) {
    list = list as List<SalesOrder>;
    void Function(SalesOrder)? f = onTapFunc as Function(SalesOrder)?;
    var w = wSalesOrderList(list: list, onTapFunc: f);
    return w;
  }
  

  @override
  Widget build(BuildContext context) {
    String header = "Outstanding Invoices";
    List<Widget> rows = [];

    for (var c in list) {
      final w = wSalesOrderCard(salesOrder: c, onTapFunc: onTapFunc);
      rows.add(w);
    }

    final w = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // MyUi.hs_sm(),
      // Container(
      //     padding: EdgeInsets.all(1),
      //     width: double.infinity,
      //     color: Colors.grey.shade200,
      //     child: Text(header, style: context.bodySmall?.copyWith(color: Colors.grey))),
      // // MyUi.hs_2xs(),
      // MyUi.hr(paddingFlag: false),
      ...rows,
    ]);

    return w;
  }
}

class wSalesOrderCard extends StatelessWidget {
  final SalesOrder salesOrder;
  final void Function(SalesOrder s)? onTapFunc;

  const wSalesOrderCard({super.key, required this.salesOrder, this.onTapFunc});


  @override
  Widget build(BuildContext context) {
    final tlg = context.titleLarge;
    final blg = context.bodyLarge;
    final blgw = blg?.copyWith(color: Colors.white);
    final bsm = context.bodySmall;

    final w = Container(
        margin: EdgeInsets.only(bottom: 6),
        // padding: EdgeInsets.symmetric(horizontal: 6.0),
        // color:Colors.grey.shade200,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyUi.hs_2xs(),
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    color: Colors.grey.shade500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.tray_full, size: 20, color: Colors.white),
                            MyUi.vs_xs(),
                            Text(salesOrder.number, style: blgw),
                          ],
                        ),
                        // Text(Utils.formatDate(salesOrder.invoiceDate), style: blgw),
                      ],
                    ),
                  ),
                  Text('${salesOrder.customerNumber} - ${salesOrder.customerName}', style: tlg),
                  Text(salesOrder.shipToAddressLine1),
                  Text('Shipping date: ${Utils.formatDate(salesOrder.orderDate)}'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Amount:", style: bsm),
                      MyUi.vs_sm(),
                      Text('\$${salesOrder.totalAmountIncludingTax.toString()}', style: tlg),
                    ],
                  ),
                ],
              ),
              onTap: () {
                // f(m);
                if (onTapFunc != null) onTapFunc!.call(salesOrder);
                Utils.log("onTapFunc ${salesOrder.id}");
              },
            ),
            MyUi.hs_2xs(),
            MyUi.hr(paddingFlag: false),
          ],
        ));

    return w;
  }
}
