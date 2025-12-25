import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/app/app.bottomsheets.dart';
import 'package:m360_app_corpsec/app/app.dialogs.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/ui/views/_layout.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'timeline_viewmodel.dart';

class TimelineView extends StackedView<TimelineViewModel> {
  const TimelineView({Key? key}) : super(key: key);
  static final _dialogService = locator<DialogService>();
  static final _bottomSheetService = locator<BottomSheetService>();
  @override
  void onViewModelReady(TimelineViewModel viewModel) async {
    await viewModel.init();
  }

  @override
  Widget builder(BuildContext context, TimelineViewModel viewModel, Widget? child) {
    final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    final tl = viewModel.timeline;

    List<Widget> arr = [];
    //arr.add(Text(tl.length.toString()));

    for (var t in tl) {
      final w = MyTimelineTile(
          child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 0, 20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(Utils.formatDate(t.eventDate)),
          MyUi.hs_xs(),
          Text(t.eventTitle, style: context.bodyLarge?.bold),
          MyUi.hs_2xs(),
          Text(t.eventDescription)
        ]),
      ));
      arr.add(w);
    }

    if (arr.isEmpty) {
      arr.add(MyTimelineTileMuted(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("There are no data available.", style: context.bodySmall).italic(),
        MyUi.hs_lg(),
        MyUi.hr()
      ])));
    } else {
      arr.add(MyTimelineTileMuted(child: nil));
    }

    //final c = SingleChildScrollView(child: Column(children: arr));
    final c = Column(children: arr);

    final l = Layout01Scaffold(
        body: CustomMaterialIndicator(
            triggerMode: IndicatorTriggerMode.anywhere,
            onRefresh: viewModel.increment,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // viewModel.increment();
                      _dialogService.showCustomDialog(
                        barrierDismissible: true,
                        variant: DialogType.aboutUs,
                        // title: 'foo',
                        // description: 'bar',
                      );
                      // _bottomSheetService.showCustomSheet(
                      //     variant: BottomSheetType.aboutUs,
                      //     isScrollControlled: true,
                      // );
                    },
                    child: Text('About Us'),
                  ),
                  ElevatedButton(onPressed: viewModel.test, child: Text('Test Service')),
                  Text(viewModel.counter.toString(), style: headerStyle),
                  Text("Company Timeline", style: headerStyle),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [MyUi.hs_sm(), viewModel.isBusy ? MyUi.loadingList() : c],
                    )),
                  )
                ])));

    return l;
  }

  @override
  TimelineViewModel viewModelBuilder(BuildContext context) => TimelineViewModel();
}

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Widget child;

  const MyTimelineTile({
    super.key,
    bool? isFirst,
    bool? isLast,
    required this.child,
  })  : isFirst = (isFirst ?? false),
        isLast = (isLast ?? false);

  @override
  Widget build(BuildContext context) {
    Widget w = TimelineTile(
      alignment: TimelineAlign.start,
      isFirst: isFirst,
      isLast: isLast,
      //hasIndicator: false,
      indicatorStyle: IndicatorStyle(
        width: 32,
        height: 32,
        padding: const EdgeInsets.all(0),
        indicatorXY: 0,
        indicator: Container(
            decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle, boxShadow: [MyUi.shadow()]),
            child: const Center(child: Icon(Icons.calendar_today_outlined, size: 16))),
      ),
      beforeLineStyle: LineStyle(
        color: Colors.grey.shade200,
        thickness: 3,
      ),
      afterLineStyle: LineStyle(
        color: Colors.grey.shade200,
        thickness: 3,
      ),
      endChild: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          child: child),
    );

    return w;
  }
}

class MyTimelineTileMuted extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Widget child;

  const MyTimelineTileMuted({
    super.key,
    bool? isFirst,
    bool? isLast,
    required this.child,
  })  : isFirst = (isFirst ?? false),
        isLast = (isLast ?? false);

  @override
  Widget build(BuildContext context) {
    Widget w = TimelineTile(
      alignment: TimelineAlign.start,
      isFirst: isFirst,
      isLast: isLast,
      //hasIndicator: false,
      indicatorStyle: IndicatorStyle(
        width: 32,
        height: 32,
        padding: const EdgeInsets.all(0),
        indicatorXY: 0,
        indicator: Container(
            decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle, boxShadow: [MyUi.shadow()]),
            child: Center(child: Icon(Icons.calendar_today_outlined, color: Colors.grey.shade300, size: 16))),
      ),
      beforeLineStyle: LineStyle(
        color: Colors.grey.shade200,
        thickness: 3,
      ),
      afterLineStyle: LineStyle(
        color: Colors.transparent,
        thickness: 3,
      ),
      endChild: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          child: child),
    );

    return w;
  }
}
