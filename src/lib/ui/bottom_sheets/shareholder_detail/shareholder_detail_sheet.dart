import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/ui/components/member_display.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'shareholder_detail_sheet_model.dart';

class ShareholderDetailSheet extends StackedView<ShareholderDetailSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ShareholderDetailSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShareholderDetailSheetModel viewModel,
    Widget? child,
  ) {
    //Member m = request.data as Member;
    Shareholder s = request.data as Shareholder;
    final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    final bodyStyle = context.bodyLarge;

    final address = s.shareholderType == "individual" ? s.address1 : s.registeredAddress.toString();

    final rows = [];
    for (final sd in s.shareDetail ?? []) {
      if (sd.numberOfShares == null || sd.numberOfShares == 0) {
        continue;
      }
      final r = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Share Type", style: headerStyle),
              Text("No. of Shares", style: headerStyle),
            ],
          ),
          MyUi.hs_2xs(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${sd.shareType.toUpperCase()}", style: bodyStyle),
              Row(
                children: [
                  Text(" ${(sd.numberOfShares as num).formatAsDecimal()} ", style: context.bodyLarge?.bold),
                  Text("(${(sd.percent as num).formatAsDecimalPercent()})", style: context.bodyLarge),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Currency", style: headerStyle),
              Text("Capital", style: headerStyle),
            ],
          ),
          MyUi.hs_2xs(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" ${sd.currency.toUpperCase()}", style: bodyStyle),
              Text(" ${(sd.capital as num).formatAsCurrency()}", style: bodyStyle),
            ],
          ),
          MyUi.hr(),
        ],
      );
      rows.add(r);
    }

    final w = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Shareholder", style: context.bodySmall),
          MyUi.hs_xs(),
          ListView(primary: false, shrinkWrap: true, padding: EdgeInsets.symmetric(vertical: 0), children: [
            Text("Name", style: headerStyle),
            wMemberDisplay.fromShareholder(s),
            MyUi.hr(paddingFlag: false),
            MyUi.hs_xs(),
            Text("Address", style: headerStyle),
            MyUi.hs_2xs(),
            Text(address?.toUpperCase() ?? " - ", style: bodyStyle),
            MyUi.hr(),
            //MyUi.hs_sm(),
            Text("Share Details", style: context.bodySmall),
            MyUi.hs_xs(),
            ...rows,
            MyUi.hs_md(),
          ])
        ],
      ),
    );
    return w;
  }

  @override
  ShareholderDetailSheetModel viewModelBuilder(BuildContext context) => ShareholderDetailSheetModel();
}
