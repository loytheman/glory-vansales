import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/ui/components/_general_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'calender_date_picker_dialog_model.dart';

class CalenderDatePickerDialog extends StackedView<CalenderDatePickerDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const CalenderDatePickerDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CalenderDatePickerDialogModel viewModel,
    Widget? child,
  ) {
    // final myStyle = Theme.of(context).extension<MyCustomStyle>();
    final DateTime today = DateTime.now();
    final DateTime startOfToday = DateTime(today.year, today.month, today.day);
    final DateTime oneWeekBefore = startOfToday.subtract(const Duration(days: 7));
    final DateTime oneWeekLater = startOfToday.add(const Duration(days: 7));

    var selectedDates = viewModel.selectedDates;

    var c = CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        firstDate: oneWeekBefore,
        lastDate: oneWeekLater,
        calendarType: CalendarDatePicker2Type.range,

        firstDayOfWeek: 1,
        daySplashColor: Colors.transparent,
        controlsHeight: 36,
        dayTextStyle: TextStyle(fontSize: 16),
        controlsTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        selectedDayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        selectedDayHighlightColor: Colors.blue.shade600,
        centerAlignModePicker: true,
        customModePickerIcon: SizedBox(),
      ),
      value: selectedDates,
      onValueChanged: viewModel.setDates,
    );

    var rows = [];
    rows.add(Text("wtf"));
    for (var d in viewModel.selectedDates) {
      var r = Text(d.toString());
      rows.add(r);
    }

    final d = MyUi.dialog(
      padding: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(">>> ${viewModel.counter}"),
          ...rows,
          Text("Select date:").paddingOnly(top: 20, left: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              wTag(text: "-1 day", onTapFunc: () {viewModel.selectDate(day:-1); }),
              wTag(text: "Today", onTapFunc: () {viewModel.selectDate(day:0); }),
              wTag(text: "+1 day", onTapFunc: () {viewModel.selectDate(day:1); }),
            ],
          ).paddingOnly(top: 12, bottom: 6),
          MyUi.hr(),
          c,
          MyUi.hr(paddingFlag: false),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () => {Navigator.pop(context)}, child: Text("CANCEL", style: context.labelLarge)),
              TextButton(onPressed: () => {}, child: Text("OK", style: context.labelLarge)),
            ],
          ).paddingOnly(top: 8, right: 8, bottom: 8)
        ],
      ),
    );

    // child: Text(text, style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),

    return d;
  }

  @override
  CalenderDatePickerDialogModel viewModelBuilder(BuildContext context) => CalenderDatePickerDialogModel(request.data["selectedDates"]);
}
