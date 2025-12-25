// ignore_for_file: camel_case_types
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/app/app.bottomsheets.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/common/constants.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/ui/components/member_display.dart';
import 'package:stacked_services/stacked_services.dart';

class wCompanyMember extends StatelessWidget {
  final Company? company;
  final bool isBusy;
  final String header;
  final List<String> roles;

  wCompanyMember({super.key, required this.header, required this.company, List<String>? roles, bool? isBusy})
      : roles = (roles ?? [MemberType.DIRECTOR]),
        isBusy = (isBusy ?? false);

  @override
  Widget build(BuildContext context) {
    final bodyStyle = context.bodyLarge;
    final c = company;

    if (c == null) {
      return Container();
    }
    List<Member>? l = c.members;
    l = l ?? [];
    bool hasRole = false;
    for (var m in l) {
      Utils.log("m.member name ${m.name}");
      Utils.log("m.member role ${m.memberRole}");
      if (roles.contains(m.memberRole)) {
        hasRole = true;
      }
    }
    if (!hasRole) {
      return Container();
    }

    // final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    // final bodyStyle = context.bodyLarge;

    List<Widget> rows = [];

    for (final m in l) {
      if (!roles.contains(m.memberRole)) {
        continue;
      }

      VoidCallback? f(m) {
        final bottomSheetService = locator<BottomSheetService>();
        bottomSheetService.showCustomSheet(
          variant: BottomSheetType.memberDetail,
          data: m,
        );
        return null;
      }

      final temp = [
        MyUi.hs_2xs(),
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: wMemberDisplay(member: m)),
              Text(m.memberRole?.toUpperCase() ?? "-", style: bodyStyle),
            ],
          ),
          onTap: () {
            f(m);
          },
        ),
        MyUi.hs_2xs(),
        MyUi.hr(paddingFlag: false),
      ];

      rows.addAll(temp);
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
