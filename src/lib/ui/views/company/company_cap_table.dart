// ignore_for_file: camel_case_types
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/app/app.bottomsheets.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/ui/components/chart.dart';
import 'package:glory_vansales_app/ui/components/member_display.dart';
import 'package:glory_vansales_app/ui/components/sticky_table.dart';
import 'package:glory_vansales_app/ui/views/company/company_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class wCompanyCapTable extends StatelessWidget {
  final Company? company;
  final bool isBusy;

  const wCompanyCapTable({super.key, required this.company, bool? isBusy}) : isBusy = (isBusy ?? false);

  @override
  Widget build(BuildContext context) {
    final c = company;

    if (c == null) {
      return Container();
    }

    final w = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getHeader(context, c),
        MyUi.hs_md(),
        getChart(context, c),
        MyUi.hs_lg(),
        getShareCapitalTable(context, c),
        MyUi.hs_lg(),
        //getShareholderTable(context, c),
        getShareholderTableSticky(context, c),

        //MyUi.hs_lg(),
      ],
    );

    return w;
  }

  Widget getHeader(BuildContext context, Company company) {
    final c = company;
    final headline = context.headlineSmall;
    final bodySmall = context.bodySmall?.copyWith(color: Colors.black);

    final fullDilluted = getFullDilutedShares(c.shareholders ?? []);
    final amtRaisedArr = getAmountRaised(c.shareCapital ?? []);
    final ar = [];
    for (var o in amtRaisedArr) {
      String c = o['currency'].toUpperCase();
      num amt = o["amount"] as num;
      final t = Text(amt.formatAsSimpleCurrency(name: "$c "), style: headline);
      ar.add(t);
    }

    final w = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text("Fully diluted shares", style: bodySmall),
            Text(fullDilluted.formatAsDecimal(), style: headline),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Amount raised", style: bodySmall),
            ...ar,
          ],
        ),
      ],
    );

    return w;
  }

  Widget getChart(BuildContext context, Company company) {
    final c = company;
    final bodySmall = context.bodySmall?.copyWith(color: Colors.black);
    final labelSmall = context.labelSmall?.copyWith(color: Colors.black);

    final fullDilluted = getFullDilutedShares(c.shareholders ?? []);

    final temp = getShareNumPerType(c.shareCapital ?? [], c.shareholders ?? []);
    List<ListData> ownershipAndFullyDilluted = [];
    for (var o in temp) {
      final shareType = o["shareType"] as String;
      final amt = o["amount"] as num;
      final w = Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(shareType.capitalizeFirst, style: labelSmall),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ownership: ", style: bodySmall),
            Text((amt / fullDilluted).formatAsDecimalPercent(decimalDigits: 2), style: bodySmall?.bold),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Diluted: ", style: bodySmall),
            Text(amt.formatAsReadableNumber(decimalDigits: 0), style: bodySmall?.bold),
          ],
        ),
      ]);
      final ld = ListData(label: shareType, value: amt, displayWidget: w);
      ownershipAndFullyDilluted.add(ld);
    }

    final temp2 = getAmountRaisedPerShareType(c.shareCapital ?? []);
    List<ListData> amountRaisedPerShareType = [];
    for (var o in temp2) {
      final shareType = o["shareType"] as String;
      final amt = o["amount"] as num;

      final w = Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(shareType.capitalizeFirst, style: labelSmall),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Raised: ", style: bodySmall),
            Text(amt.formatAsCurrency(decimalDigits: 0), style: bodySmall?.bold),
          ],
        ),
      ]);

      final ld = ListData(label: shareType, value: amt, displayWidget: w);
      amountRaisedPerShareType.add(ld);
    }

    final w = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 150, height: 180, child: wPieChart.fromListData(ownershipAndFullyDilluted)),
            SizedBox(width: 150, height: 180, child: wPieChart.fromListData(amountRaisedPerShareType)),
          ],
        ),
        Text("*Data are rounded to the nearest decimal place.", style: context.bodySmall?.copyWith(color: Colors.grey)),
      ],
    );

    return w;
  }

  Widget getShareCapitalTable(BuildContext context, Company company) {
    final c = company;
    //final temp = getShareNumPerType (c.shareCapital??[],c.shareholders??[]);

    final List<DataRow> rows = [];

    for (final st in c.shareCapital ?? []) {
      num totalShareNum = calculateTotalShare(c.shareholders ?? [], shareTypeId: st.shareTypeId);
      final r = DataRow(
        cells: [
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyUi.hs_2xs(),
              Text(st.shareTypeId.toUpperCase()),
              Text("${totalShareNum.formatAsDecimal()} share(s)", style: context.bodySmall),
            ],
          )),
          //DataCell(Text(st.currency.toUpperCase())),
          DataCell(Text((st.amountOfCapital as num).formatAsCurrency())),
          DataCell(Text((st.paidUpCapital as num).formatAsCurrency())),
        ],
      );
      rows.add(r);
    }

    final tbl = DataTable(
      horizontalMargin: 0,
      columnSpacing: 0,
      headingRowHeight: 40,
      dataRowMinHeight: 10,
      dataRowMaxHeight: 42,
      headingTextStyle: context.bodySmall?.copyWith(color: Colors.grey),
      dataTextStyle: context.bodyMedium,
      headingRowColor: WidgetStateProperty.resolveWith(((Set<WidgetState> states) {
        return Colors.grey.shade200;
      })),
      columns: [
        DataColumn(label: Text(' Share Type')),
        //DataColumn(label: Text('Currency', style:context.bodySmall?.copyWith(color: Colors.grey))),
        DataColumn(label: Text('Issued Share\nCapital')),
        DataColumn(label: Text('Paid-Up\nCapital')),
      ],
      //border: TableBorder.all(color: Colors.black),
      rows: rows,
    );

    final w = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text("Share Capital"),
          SizedBox(
            width: double.infinity,
            child: tbl,
          ),
        ],
      ),
    );
    return w;
  }

  Widget getShareholderTable(BuildContext context, Company company) {
    final c = company;
    //final temp = getShareNumPerType (c.shareCapital??[],c.shareholders??[]);

    final List<DataRow> rows = [];

    for (Shareholder sh in c.shareholders ?? []) {
      final List<DataCell> dataCols = [];
      //final rId = sh.referenceId;
      for (ShareCapital sc in c.shareCapital ?? []) {
        try {
          ShareDetail? sd = sh.shareDetail?.firstWhere((sd) => sd.shareTypeId == sc.shareTypeId);
          if (sd != null) {
            if (sd.numberOfShares == 0) {
              throw "no shares in share type";
            }
            num totalShareNum = calculateTotalShare(c.shareholders ?? [], shareTypeId: sc.shareTypeId);
            //final sd = getShareholderShare(c.shareholders, rId, sc.shareTypeId);
            //final percent = (sd.numberOfShares / totalShareNum).formatAsDecimalPercent(decimalDigits: 2);
            num capital = (sd.numberOfShares / totalShareNum) * sc.amountOfCapital;
            final col = DataCell(Text("${sd.numberOfShares} \n ${capital.formatAsCurrency()}"));
            dataCols.add(col);
          }
        } catch (e) {
          final col = DataCell(Text(" "));
          dataCols.add(col);
          //Utils.err(e);
        }
      }

      final r = DataRow(
        cells: [
          DataCell(wMemberDisplay.fromShareholder(sh)),
          //DataCell(Text(sh.name)),
          ...dataCols,
        ],
      );
      rows.add(r);
    }

    final List<DataColumn> cols = [];
    for (var s in c.shareCapital ?? []) {
      String st = s.shareType;
      final col = DataColumn(label: Text("${st.capitalizeFirst} \n${s.currency.toUpperCase()}"));
      cols.add(col);
    }

    final tbl = DataTable(
      horizontalMargin: 0,
      columnSpacing: 0,
      headingRowHeight: 40,
      dataRowMinHeight: 10,
      dataRowMaxHeight: 48,
      headingTextStyle: context.bodySmall?.copyWith(color: Colors.grey),
      dataTextStyle: context.bodyMedium,
      headingRowColor: WidgetStateProperty.resolveWith(((Set<WidgetState> states) {
        return Colors.grey.shade200;
      })),
      columns: [
        DataColumn(label: Text(' Shareholder')),
        //DataColumn(label: Text('Currency', style:context.bodySmall?.copyWith(color: Colors.grey))),
        // DataColumn(label: Text('Ordinary')),
        // DataColumn(label: Text('Preference ')),
        ...cols
      ],
      //border: TableBorder.all(color: Colors.black),
      rows: rows,
    );

    final w = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text("Share Capital"),
          SizedBox(
            width: double.infinity,
            child: tbl,
          ),
        ],
      ),
    );
    return w;
  }

  Widget getShareholderTableSticky(BuildContext context, Company company) {
    final c = company;
    //final temp = getShareNumPerType (c.shareCapital??[],c.shareholders??[]);

    final List<Shareholder> sh_arr = [];
    final List<List<ShareDetail>> rows = [];

    for (Shareholder sh in c.shareholders ?? []) {
      final List<ShareDetail> dataCols = [];
      sh_arr.add(sh);
      for (ShareCapital sc in c.shareCapital ?? []) {
        try {
          ShareDetail? sd = sh.shareDetail?.firstWhere((sd) => sd.shareTypeId == sc.shareTypeId);
          if (sd != null) {
            if (sd.numberOfShares == 0) {
              throw "no shares in share type";
            }
            num totalShareNum = calculateTotalShare(c.shareholders ?? [], shareTypeId: sc.shareTypeId);
            //final sd = getShareholderShare(c.shareholders, rId, sc.shareTypeId);
            num percent = (sd.numberOfShares / totalShareNum);
            num capital = (sd.numberOfShares / totalShareNum) * sc.amountOfCapital;
            //final col = "${sd.numberOfShares} \n ${capital.formatAsCurrency()}";
            //final o = {"numberOfShares": sd.numberOfShares, "percent": percent, "capital": capital};
            var detail = ShareDetail(shareType: sd.shareType, currency: sd.currency, numberOfShares: sd.numberOfShares);
            detail.percent = percent;
            detail.capital = capital;
            dataCols.add(detail);
          }
        } catch (e) {
          //final o = {"numberOfShares": null, "percent": null, "capital": null};
          dataCols.add(ShareDetail.empty());
          //Utils.err(e);
        }
      }
      rows.add(dataCols);
    }

    final List<String> titleCols = [];
    for (var s in c.shareCapital ?? []) {
      String st = s.shareType;
      final col = "${st.capitalizeFirst} \n${s.currency.toUpperCase()}";
      titleCols.add(col);
    }

    final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    Widget getLegend(String txt) {
      final w = Text(txt, style: headerStyle, textAlign: TextAlign.left);
      final w2 = MyTableCell.legendCell(child: w);
      return w2;
    }

    Widget getTitleCol(int i) {
      final w = Text(titleCols[i], style: headerStyle);
      final w2 = MyTableCell.headerCell(child: w);
      return w2;
    }

    Widget getShareholder(int i) {
      final sh = sh_arr[i];
      final w =
          Stack(clipBehavior: Clip.antiAlias, fit: StackFit.expand, children: [wMemberDisplay.fromShareholder(sh)]);
      final w2 = MyTableCell.stickyBodyCell(child: w);
      return w2;
    }

    Widget getShareholderCellData(int i, int j) {
      final sd = rows[j][i];
      final t1 = sd.numberOfShares;
      final t2 = sd.percent;
      final t3 = sd.capital;
      final w = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Text(t1 != 0 ? t1.formatAsDecimal() : "", style: context.bodySmall?.bold),
            // MyUi.vs_xs(),
            Text(t2 != null ? " (${t2.formatAsDecimalPercent()})" : "", style: context.bodySmall),
          ]),
          Text(t3?.formatAsCurrency() ?? "", style: context.bodySmall?.bold),
        ],
      );
      final w2 = MyTableCell.bodyCell(child: w);
      return w2;
    }

    final halfWidth = MediaQuery.of(context).size.width / 2;
    double shareTypeNum = c.shareCapital?.length.toDouble() ?? 1;

    CellDimensions cellDim = CellDimensions.fixed(
      contentCellWidth: halfWidth / shareTypeNum,
      contentCellHeight: 48,
      stickyLegendWidth: halfWidth,
      stickyLegendHeight: 36,
    );

    VoidCallback? onTapShareholder(j) {
      Shareholder? s = c.shareholders?[j];
      s?.shareDetail = rows[j];
      final bottomSheetService = locator<BottomSheetService>();
      bottomSheetService.showCustomSheet(
        variant: BottomSheetType.shareholderDetail,
        data: s,
      );
      return null;
    }

    VoidCallback? onTapShareholderCell(i, j) {
      onTapShareholder(j);
      return null;
    }

    final w = StickyHeadersTable(
      columnsLength: titleCols.length,
      rowsLength: rows.length,
      columnsTitleBuilder: (i) => getTitleCol(i),
      rowsTitleBuilder: (i) => getShareholder(i),
      contentCellBuilder: (i, j) => getShareholderCellData(i, j),
      legendCell: getLegend(' Shareholder'),
      showVerticalScrollbar: false,
      cellDimensions: cellDim,
      onRowTitlePressed: onTapShareholder,
      onContentCellPressed: onTapShareholderCell,
    );

    final h = 40.0 + (rows.length * 48);
    final w2 = SizedBox(width: double.infinity, height: h, child: w);

    return w2;
  }
}
