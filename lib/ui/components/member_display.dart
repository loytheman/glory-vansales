// ignore_for_file: camel_case_types
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.company.dart';

class wMemberDisplay extends StatelessWidget {
  final Member? member;
  final VoidCallback? onClickFunc;
  final bool showCompact;
  final bool isBusy;

  const wMemberDisplay({super.key, required this.member, this.onClickFunc, bool? showCompact, bool? isBusy})
      : showCompact = (showCompact ?? false),
        isBusy = (isBusy ?? false);

  factory wMemberDisplay.fromShareholder(Shareholder s) {
    Member m = Member();
    m.name = s.name;
    m.firstName = s.firstName;
    m.lastName = s.lastName;
    m.memberType = s.shareholderType;
    m.idNo = s.idNo;
    m.registeredNumber = s.registeredNumber;

    final w = wMemberDisplay(
      member: m,
      showCompact: true,
    );
    return w;
  }

  @override
  Widget build(BuildContext context) {
    final m = member;

    if (m == null) {
      return Container();
    }

    var icon = m.memberType == "individual"
        ? Icon(CupertinoIcons.profile_circled)
        : Icon(
            CupertinoIcons.briefcase,
            size: 24,
          );
    var idNum = m.memberType == "individual" ? m.idNo : m.registeredNumber;

    Widget w = Row(children: [
      SizedBox(
        width: 24,
        child: icon,
      ),
      MyUi.vs_sm(),
      Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 0,
            children: [
              Text(m.name ?? "-", overflow: TextOverflow.ellipsis, maxLines: 1, style: context.bodyMedium),
              Text(idNum ?? "-", overflow: TextOverflow.ellipsis, maxLines: 1, style: context.bodySmall),
            ]),
      )
    ]);

    if (onClickFunc != null) {
      w = InkWell(
          child: w,
          onTap: () {
            if (onClickFunc != null) {
              onClickFunc?.call();
            }
            Utils.log("onTap ${m.referenceId}");
          });
    }

    return w;
  }
}
