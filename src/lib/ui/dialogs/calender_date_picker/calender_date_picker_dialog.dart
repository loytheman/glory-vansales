import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:glory_vansales_app/common/theme.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/ui/common/app_colors.dart';
import 'package:glory_vansales_app/ui/common/ui_helpers.dart';
import 'package:glory_vansales_app/ui/components/_general_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'calender_date_picker_dialog_model.dart';

const double _graphicSize = 60;

class CalenderDatePickerDialog extends StackedView<CalenderDatePickerDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const CalenderDatePickerDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder( BuildContext context, CalenderDatePickerDialogModel viewModel, Widget? child,) {

    final myStyle = Theme.of(context).extension<MyCustomStyle>();

    var c = CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        controlsHeight: 36,
        firstDayOfWeek: 1,
        calendarType: CalendarDatePicker2Type.single,
        daySplashColor: Colors.transparent,
        dayTextStyle: TextStyle(fontSize: 16),
        controlsTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        selectedDayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        selectedDayHighlightColor: Colors.blue.shade600,
        centerAlignModePicker: true,
        customModePickerIcon: SizedBox(),
      ),
      value: [],
      onValueChanged: (dates) => {},
    );


    final d = MyUi.dialog(
      padding: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select date:").paddingOnly(top:20, left:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              wTag(text: "-1 day", onTapFunc: ()=>{}),
              wTag(text: "Today"),
              wTag(text: "+1 day"),
            ],
          ).paddingOnly(top: 12, bottom: 6),
          MyUi.hr(),
          c,
          MyUi.hr(paddingFlag: false),
          Row( 
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            TextButton(onPressed: ()=>{}, child: Text("CANCEL", style: context.labelLarge)),
            TextButton(onPressed: ()=>{}, child: Text("OK", style: context.labelLarge)),
          ],).paddingOnly(top:8, right: 8, bottom: 8)
        ],
      ),
    );

    // child: Text(text, style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),

    return d;
  }

  @override
  CalenderDatePickerDialogModel viewModelBuilder(BuildContext context) => CalenderDatePickerDialogModel();
}
