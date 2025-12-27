// ignore_for_file: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/models/model.salesInvoice.dart';

class wSalesInvoiceList extends StatelessWidget {
  final List<SalesInvoice> list;
  final void Function(SalesInvoice s)? onTapFunc;

  const wSalesInvoiceList({ super.key, required this.list, this.onTapFunc });

  @override
  Widget build(BuildContext context) {
    String header = "Outstanding Invoices";
    List<Widget> rows = [];

    for (var c in list) {
      final w = wSalesInvoiceCard(salesInvoice: c, onTapFunc: onTapFunc);
      rows.add(w);
    }

    final w = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // MyUi.hs_sm(),
      Container(
          padding: EdgeInsets.all(1),
          width: double.infinity,
          color: Colors.grey.shade200,
          child: Text(header, style: context.bodySmall?.copyWith(color: Colors.grey))),
      // MyUi.hs_2xs(),
      MyUi.hr(paddingFlag: false),
      ...rows,
    ]);

    return w;
  }
}

class wSalesInvoiceCard extends StatelessWidget {
  final SalesInvoice salesInvoice;
  final void Function(SalesInvoice s)? onTapFunc;

  const wSalesInvoiceCard({ super.key, required this.salesInvoice, this.onTapFunc});

  @override
  Widget build(BuildContext context) {
    final tlg = context.titleLarge;
    final blg = context.bodyLarge;
    final blgw = blg?.copyWith(color: Colors.white);
    final bsm = context.bodySmall;

    Widget w = Container(
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
                            Text(salesInvoice.number, style: blgw),
                          ],
                        ),
                        // Text(Utils.formatDate(salesInvoice.invoiceDate), style: blgw),
                      ],
                    ),
                  ),
                  Text('${salesInvoice.customerNumber} - ${salesInvoice.customerName}', style: tlg),
                  Text(salesInvoice.shipToAddressLine1),
                  Text('Shipping date: ${Utils.formatDate(salesInvoice.invoiceDate)}'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Amount:", style: bsm),
                      MyUi.vs_sm(),
                      Text('\$${salesInvoice.totalAmountIncludingTax.toString()}', style: tlg),
                    ],
                  ),
                ],
              ),
              onTap: () {
                // f(m);
                if(onTapFunc != null) onTapFunc!.call(salesInvoice);
                Utils.log("onTapFunc ${salesInvoice.id}");
              },
            ),
            MyUi.hs_2xs(),
            MyUi.hr(paddingFlag: false),
          ],
        ));

    return w;
  }
}
