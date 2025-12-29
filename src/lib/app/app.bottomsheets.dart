// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/about_us/about_us_sheet.dart';
import '../ui/bottom_sheets/member_detail/member_detail_sheet.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';
import '../ui/bottom_sheets/shareholder_detail/shareholder_detail_sheet.dart';

enum BottomSheetType {
  notice,
  memberDetail,
  shareholderDetail,
  aboutUs,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) => NoticeSheet(request: request, completer: completer),
    BottomSheetType.memberDetail: (context, request, completer) =>
        MemberDetailSheet(request: request, completer: completer),
    BottomSheetType.shareholderDetail: (context, request, completer) =>
        ShareholderDetailSheet(request: request, completer: completer),
    BottomSheetType.aboutUs: (context, request, completer) => AboutUsSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
