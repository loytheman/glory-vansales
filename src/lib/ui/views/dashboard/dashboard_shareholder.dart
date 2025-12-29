// ignore_for_file: camel_case_types
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/ui/components/chart.dart';
import 'package:glory_vansales_app/ui/views/company/company_shareholder_legend.dart';
import 'package:glory_vansales_app/ui/views/company/company_viewmodel.dart';

class wDashboardShareholder extends StatelessWidget {
  final Company? company;
  final bool isBusy;

  const wDashboardShareholder({super.key, required this.company, bool? isBusy}) : isBusy = (isBusy ?? false);

  @override
  Widget build(BuildContext context) {
    final c = company;

    if (c == null) {
      return Container();
    }

    // final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    // final bodyStyle = context.bodyLarge;

    num paidUpCapital = 0.0;
    paidUpCapital = getPaidUpCapital(c.shareCapital ?? []);
    num ordinaryTotalShare = calculateTotalShare(c.shareholders ?? []);
    List<Shareholder> l = calculateShareholderPercent(c.shareholders, totalShare: ordinaryTotalShare);
    l = sortLargestShareholder(l);
    l = prepareTop3Shareholder(l, totalShare: ordinaryTotalShare);

    final shareholderList = ListData.fromShareholders(l);

    final w = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ordinary Shares (SGD)", style: context.bodyLarge),
        Text(paidUpCapital.formatAsCurrency(), style: context.headlineSmall),
        MyUi.hs_lg(),
        SizedBox(
            width: double.infinity,
            height: 46,
            child: wMeterChart.fromListData(shareholderList, rangeEnd: ordinaryTotalShare)),
        // SizedBox(width: 150, height: 180,child: wPieChart.fromListData(shareholderList)),
        wCompanyShareholderLegend(shareholderList: l),
        MyUi.hs_lg(),
      ],
    );

    return w;
  }
}
