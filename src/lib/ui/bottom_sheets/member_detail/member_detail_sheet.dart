import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/ui/components/member_display.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'member_detail_sheet_model.dart';

class MemberDetailSheet extends StackedView<MemberDetailSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const MemberDetailSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, MemberDetailSheetModel viewModel, Widget? child) {
    Member m = request.data as Member;
    final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    final bodyStyle = context.bodyLarge;

    var address = "-";
    if (m.memberType == "individual") {
      address = "${m.address1} ${m.postcode}".toUpperCase();
    } else {
      address = m.registeredAddress != null ? m.registeredAddress.toString() : "-";
    }
    //var address = m.address1 != null ? "-" :  m.address1;
    // if (m.address1 != null && m.postcode != null) {
    //   address = "${m.address1} ${m.postcode}".toUpperCase();
    // }

    // /${m.address2}

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
          //Text("Member / Officer", style: context.bodySmall),
          MyUi.hs_xs(),
          ListView(primary: false, shrinkWrap: true, padding: EdgeInsets.symmetric(vertical: 0), children: [
            Text("Name", style: headerStyle),
            wMemberDisplay(member: m),
            MyUi.hr(paddingFlag: false),
            MyUi.hs_xs(),
            Text("Address", style: headerStyle),
            MyUi.hs_2xs(),
            Text(address, style: bodyStyle),
            MyUi.hr(),
            Text("Role", style: headerStyle),
            MyUi.hs_2xs(),
            Text(m.memberRole?.toUpperCase() ?? "-", style: bodyStyle),
            MyUi.hr(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Appointment Date", style: headerStyle),
                Text("Cessation Date", style: headerStyle),
              ],
            ),
            MyUi.hs_2xs(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Utils.formatDate(m.appointmentDate), style: bodyStyle),
                Text(Utils.formatDate(m.cessationDate), style: bodyStyle),
              ],
            ),
            MyUi.hr(),
          ])
        ],
      ),
    );
    return w;
  }

  @override
  MemberDetailSheetModel viewModelBuilder(BuildContext context) => MemberDetailSheetModel();
}
