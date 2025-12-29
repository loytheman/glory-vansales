// ignore_for_file: camel_case_types
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/constants.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.company.dart';

class wCompanyShareholderLegend extends StatelessWidget {
  final List<Shareholder> shareholderList;
  final bool isBusy;

  const wCompanyShareholderLegend({super.key, required this.shareholderList, bool? isBusy})
      : isBusy = (isBusy ?? false);

  @override
  Widget build(BuildContext context) {
    final colors = ChartColor.set1;
    final l = shareholderList;

    if (l.isEmpty) {
      return Container();
    }

    // final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    // final bodyStyle = context.bodyLarge;

    final lv = ListView.builder(
        primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        itemCount: l.length,
        itemBuilder: (context, i) {
          final sh = l[i];
          final shareTypeId = "ordinary-sgd";
          final sd = sh.shareDetail.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);
          final w = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyUi.bullet(color: Color(colors[i % colors.length])),
              MyUi.vs_xs(),
              sh.shareholderType == "individual"
                  ? Text("${sh.name}  (${sd?.percent?.toPercent()})", style: context.bodyMedium)
                  : Text("${sh.companyName}  (${sd?.percent?.toPercent()})", style: context.bodyMedium)
              //Text("${sd?.percent?.toPercent()}"),
            ],
          );
          return w;
        });

    final w = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Text("Shareholders*", style: context.bodySmall?.copyWith(color: Colors.grey)),
        ),
        MyUi.hs_sm(),
        lv,
        MyUi.hs_xs(),
        Text("*Percentage points are rounded to the nearest 2nd decimal place.",
            style: context.bodySmall?.copyWith(color: Colors.grey)),
      ],
    );

    return w;
  }
}
