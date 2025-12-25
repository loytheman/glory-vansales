//ref: https://github.com/imaNNeo/fl_chart/blob/main/repo_files/documentations/pie_chart.md
// ignore_for_file: camel_case_types

import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:m360_app_corpsec/common/constants.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/models/model.company.dart';

class wPieChart extends StatelessWidget {
  static final colors = ChartColor.set2;
  final bool isBusy;
  final List<PieChartSectionData>? data;

  const wPieChart({super.key, this.data, bool? isBusy}) : isBusy = (isBusy ?? false);

  @override
  Widget build(BuildContext context) {
    final d = data;

    if (d == null) {
      return Text("no data");
    }

    // final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    // final bodyStyle = context.bodyLarge;

    final w = PieChart(
      PieChartData(startDegreeOffset: 250, sectionsSpace: 1, sections: data),
    );

    return w;
  }

  factory wPieChart.fromListData(List<ListData> ld) {
    final d = wPieChart._createChartSectionDataList(ld);
    final w = wPieChart(data: d);
    return w;
  }

  static List<PieChartSectionData> _createChartSectionDataList(List<ListData> list) {
    //final radius = 45.0;
    final offsetPos = 0.55;
    final l = List.generate(list.length, (i) {
      final d = list[i];
      final c = colors[i % colors.length];
      var displayWidget = MyUi.whiteLabel(text: d.label);
      if (d.displayWidget != null) {
        displayWidget = Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.blueAccent),
              color: Colors.white70,
            ),
            child: d.displayWidget);
      }
      final w = PieChartSectionData(
        color: Color(c),
        value: d.value + 0.0,
        title: " ",
        //title: d.label,
        //titlePositionPercentageOffset: offsetPos,
        //radius: radius,
        badgeWidget: displayWidget,
        badgePositionPercentageOffset: offsetPos,
      );
      return w;
    });
    return l;
  }
}

class wMeterChart extends StatelessWidget {
  static final colors = ChartColor.set1;
  final bool isBusy;
  final List<RangeLinearGauge>? data;
  final num rangeEnd;

  const wMeterChart({super.key, required this.data, required this.rangeEnd, bool? isBusy}) : isBusy = (isBusy ?? false);

  @override
  Widget build(BuildContext context) {
    final d = data;

    if (d == null) {
      return Text("no data");
    }

    final w = LinearGauge(
        start: 0,
        end: rangeEnd + 0.0,
        //end: 1389478,
        linearGaugeBoxDecoration: const LinearGaugeBoxDecoration(thickness: 6, backgroundColor: Colors.white),
        rulers: RulerStyle(
          rulerPosition: RulerPosition.bottom,
          showPrimaryRulers: false,
          showSecondaryRulers: false,
          showLabel: false,
        ),
        rangeLinearGauge: data);

    return w;
  }

  factory wMeterChart.fromListData(List<ListData> ld, {required num rangeEnd}) {
    final d = wMeterChart.createChartSectionDataList(ld);
    final w = wMeterChart(
      data: d,
      rangeEnd: rangeEnd,
    );
    return w;
  }

  static List<RangeLinearGauge> createChartSectionDataList(List<ListData> l) {
    // final offsetPos = 0.55;
    double totalValue = 0;
    final list = List<ListData>.from(l);
    //list.sort((a, b) => b.value.compareTo(a.value));

    final l2 = List.generate(list.length, (i) {
      final d = list[i];
      final c = colors[i % colors.length];
      final start = i < 1 ? totalValue : (totalValue * 0.97);
      final end = totalValue + d.value;
      //final w = RangeLinearGauge(color: Color(c), start: d.value as double, end: 20);
      final w = RangeLinearGauge(
          color: Color(c), start: start, end: end, borderRadius: 10, edgeStyle: LinearEdgeStyle.bothCurve);
      totalValue = end;
      //Utils.log("totalValue: ${d.value} ? $end");
      return w;
    });

    return l2.reversed.toList();
  }
}

///###############

class ListData {
  final String label;
  final num value;
  Widget? displayWidget;

  ListData({required this.label, required this.value, this.displayWidget});

  static List<ListData> randomDataList() {
    final n = randomInRange(1, 10);
    final l = List.generate(n, (i) {
      final d = ListData(label: "Rnd $i", value: randomInRange(10, 50) + 0.0);
      return d;
    });
    return l;
  }

  static List<ListData> fromShareholders(List<Shareholder>? l, [String shareTypeId = "ordinary-sgd"]) {
    //final n = randomInRange(1, 10);
    l = l ?? [];
    final List<ListData> l2 = [];
    for (var i = 0; i < l.length; i++) {
      final sh = l[i];
      final sd = sh.shareDetail.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);
      if (sd != null) {
        //final ld = ListData(label: sh.name, value: sd.numberOfShares + 0.0);
        final ld = ListData(label: sd.percent?.toPercent() ?? "", value: sd.numberOfShares + 0.0);
        l2.add(ld);
      }
    }
    return l2;
  }
}
