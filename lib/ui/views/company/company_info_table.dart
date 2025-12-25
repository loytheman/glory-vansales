// ignore_for_file: camel_case_types

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jiffy/jiffy.dart';
import 'package:m360_app_corpsec/common/theme.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/ui/components/country_flag.dart';
import 'package:url_launcher/url_launcher.dart';

class wCompanyInfoTable extends StatelessWidget {
  final Company? company;
  final bool isBusy;
  final bool isCompact;

  //const wCompanyInfoTable({super.key, required this.company, bool? isBusy, bool compact = true}) : isBusy = (isBusy ?? false);
  const wCompanyInfoTable({super.key, required this.company, bool? isCompact, bool? isBusy})
      : isCompact = (isCompact ?? true),
        isBusy = (isBusy ?? false);

  @override
  Widget build(BuildContext context) {
    final c = company;

    //Utils.log("compact $isCompact");

    if (c == null) {
      return Container();
    }

    final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    final bodyStyle = context.bodyLarge;

    final List<Widget> widgets = [];
    if (c.companyName != null) {
      widgets.addAll([
        Text("Company Name", style: headerStyle),
        MyUi.hs_2xs(),
        Text(c.companyName!, style: bodyStyle),
        MyUi.hr(),
      ]);
    }

    if (c.registeredNumber != null) {
      widgets.addAll([
        Text("Registered Number (UEN)", style: headerStyle),
        MyUi.hs_2xs(),
        Text(c.registeredNumber!, style: bodyStyle),
        MyUi.hr(),
      ]);
    }

    if (!isCompact && c.companyStructureType != null) {
      widgets.addAll([
        Text("Company Type", style: headerStyle),
        MyUi.hs_2xs(),
        Text(c.companyStructureType!.toUpperCase(), style: bodyStyle),
        MyUi.hr(),
      ]);
    }

    if (!isCompact && c.incorporationDate != null) {
      widgets.addAll([
        Text("Incorporation Date", style: headerStyle),
        MyUi.hs_2xs(),
        Text(Jiffy.parse(c.incorporationDate!).yMMMd, style: bodyStyle),
        MyUi.hr(),
      ]);
    }

    if (!isCompact && c.countryOfIncorporation != null) {
      widgets.addAll([
        Text("Country Of Incorporation", style: headerStyle),
        MyUi.hs_2xs(),
        Row(children: [
          wCountryFlag(countryCode: c.countryOfIncorporation).paddingLTRB(2, 0, 8, 0),
          Text(c.countryOfIncorporation!.toUpperCase(), style: bodyStyle),
        ]),
        MyUi.hr(),
      ]);
    }

    if (!isCompact && c.companyStatus != null) {
      widgets.addAll([
        Text("Company Status", style: headerStyle),
        MyUi.hs_2xs(),
        Text(c.companyStatus!.toUpperCase(), style: bodyStyle),
        MyUi.hr(),
      ]);
    }

    final a1 = company?.companyActivity?["activity1"];
    final a2 = company?.companyActivity?["activity2"];
    if (a1?.code.isNotEmpty) {
      widgets.addAll([
        Text("Business Activity", style: headerStyle),
        MyUi.hs_2xs(),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${a1?.code}", style: bodyStyle),
          MyUi.vs_md(),
          Text("${a1.title}", style: bodyStyle).flexible(),
        ])
      ]);
    }

    if (a2 != null && a2.code.isNotEmpty) {
      widgets.addAll([
        MyUi.hs_xs(),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${a2.code}", style: bodyStyle),
          MyUi.vs_md(),
          Text("${a2.title}", style: bodyStyle).flexible(),
        ])
      ]);
    }
    if (a1 != null && a2 != null) {
      widgets.add(MyUi.hr());
    }

    if (!isCompact && c.registeredAddress!.isNotEmpty()) {
      widgets.addAll([
        Text("Registered Address", style: headerStyle),
        MyUi.hs_2xs(),
        Text(c.registeredAddress!.toString().toUpperCase(), style: bodyStyle),
        MyUi.hr(),
      ]);
    }

    if (!isCompact && c.businessOpAddress!.isNotEmpty()) {
      widgets.addAll([
        Text("Business Address", style: headerStyle),
        MyUi.hs_2xs(),
        Text(c.businessOpAddress!.toString().toUpperCase(), style: bodyStyle),
        MyUi.hr(),
      ]);
    }

    if (c.nextFinancialYearEndDate != null) {
      final d = Jiffy.parse(c.nextFinancialYearEndDate!);
      widgets.addAll([
        Text("Next Financial Year End Date", style: headerStyle),
        MyUi.hs_2xs(),
        Row(
          children: [
            Text(d.yMMMd, style: bodyStyle),
            MyUi.vs_lg(),
            Text("(${d.fromNow()})", style: context.bodySmall?.copyWith(color: Colors.grey)),
          ],
        ),
        MyUi.hr(),
      ]);
    }

    if (c.lastAnnualGeneralMeeting != null) {
      widgets.addAll([
        Text("Last Annual General Meeting", style: headerStyle),
        MyUi.hs_2xs(),
        Text(Jiffy.parse(c.lastAnnualGeneralMeeting!).yMMMd, style: bodyStyle),
        MyUi.hr(),
      ]);
    }

    final myStyle = Theme.of(context).extension<MyCustomStyle>();

    if (!isCompact) {
      widgets.addAll([
        MyUi.hs_lg(),
        // RichText(text: TextSpan(children: [
        //   TextSpan(text:"*Company infomation is dated based on the last bizfile. Please contact", style: context.bodySmall?.copyWith(color: Colors.grey)),
        //   TextSpan(text:" support@meyzer360.com ", style: context.bodySmall?.copyWith(color: myStyle?.linkColor)),
        //   TextSpan(text:"for any discrepancies.", style: context.bodySmall?.copyWith(color: Colors.grey)),
        // ]),)
        Linkify(
          onOpen: (link) async {
            if (!await launchUrl(Uri.parse(link.url))) {
              throw Exception('Could not launch ${link.url}');
            }
          },
          text:
              "*Company infomation is dated based on the last bizfile. Please contact support@meyzer360.com for any discrepancies.",
          style: context.bodySmall?.copyWith(color: Colors.grey),
          linkStyle: context.bodySmall?.copyWith(color: myStyle?.linkColor),
        )
      ]);
    }

    final w = ListView(primary: false, shrinkWrap: true, padding: EdgeInsets.symmetric(vertical: 0), children: widgets);

    return w;
  }
}
