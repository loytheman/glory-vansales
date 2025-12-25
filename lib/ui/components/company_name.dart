// ignore_for_file: camel_case_types

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_text_widget/smart_text_widget.dart';

class wCompanyName extends StatelessWidget {
  final VoidCallback? onClickFunc;
  final Map<String, String?>? coData;
  final bool scrollFlag;

  // final d =  {
  //     "companyName": "DUMMY PTE LTD",
  //     "registeredNumber": "201423478B",
  //   };

  const wCompanyName({super.key, this.onClickFunc, this.coData, bool? scrollFlag}) : scrollFlag = (scrollFlag ?? false);

  @override
  Widget build(BuildContext context) {
    Widget w = label(context);

    if (onClickFunc != null) {
      w = TextButton(
        onPressed: onClickFunc,
        child: label(context),
      );
    }

    return w;
  }

  Widget label(BuildContext context) {
    String? t1 = coData?['companyName'];
    String? t2 = coData?['registeredNumber'];

    // final w = Row(children: [
    //   const Icon(CupertinoIcons.briefcase),
    //   MyUi.vs_sm(),
    //   Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       ...(t1 != null ? [Text(t1, overflow:TextOverflow.ellipsis, maxLines:1, style: context.titleLarge)] : []),
    //       ...(t2 != null ? [Text(t2, style: context.bodySmall)] : []),
    //     ],
    //   ).expanded(),
    // ]);

    final titleTxt = scrollFlag
        ? RTText(
            text: t1,
            scroll: true,
            maxWidth: false,
            //truncateSize: 20,
            //truncateEnable: true,
            textStyle: context.titleLarge)
        : Text(t1 ?? "", overflow: TextOverflow.ellipsis, maxLines: 1, style: context.titleLarge);

    final w2 = ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(0),
      visualDensity: VisualDensity(horizontal: -2, vertical: -4),
      leading: Icon(
        CupertinoIcons.briefcase,
        size: 24,
      ),
      title: t1 != null ? titleTxt : null,
      subtitle: t2 != null ? Text(t2, style: context.bodySmall) : null,
    );

    return w2;
  }
}
