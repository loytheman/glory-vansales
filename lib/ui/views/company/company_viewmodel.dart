import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/services/company_service.dart';
import 'package:stacked/stacked.dart';

class CompanyViewModel extends ReactiveViewModel {
  final _companyService = locator<CompanyService>();
  int tabIndex = 0;
  Company? get company => _companyService.currentCompany;

  Future<void> refreshData() async {
    setBusy(true);
    company?.id ?? _companyService.getCompany(company!.id!);
    setBusy(false);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_companyService];
}

//company shareholder helpers
List<Shareholder> calculateShareholderPercent(
  List<Shareholder>? l, {
  required num totalShare,
  String shareTypeId = "ordinary-sgd",
}) {
  List<Shareholder> l2 = [];

  l?.forEach((o) {
    //for (var o in l) {
    final shareDetails = o.shareDetail;
    final sd = shareDetails?.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);
    if (sd != null) {
      num percent = sd.numberOfShares / totalShare;
      sd.percent = percent;
    }

    var sh = Shareholder();
    sh = o.clone();
    if (sd != null) {
      sh.shareDetail = [sd];
      l2.add(sh);
    }
  });

  return l2;
}

List<Shareholder> sortLargestShareholder(List<Shareholder>? l, {String shareTypeId = "ordinary-sgd"}) {
  l?.sort((a, b) {
    final sd1 = a.shareDetail?.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);
    final sd2 = b.shareDetail?.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);

    int compare = -1;
    if (sd1 != null && sd2 != null) {
      if (sd1.numberOfShares > sd2.numberOfShares) {
        return -1;
      } else {
        return 1;
      }
    }
    return compare;
  });

  return l ?? [];
}

List<Shareholder> prepareTop3Shareholder(List<Shareholder> l,
    {required num totalShare, String shareTypeId = "ordinary-sgd"}) {
  List<Shareholder> l2 = [];
  num ordinaryTotalOtherShare = 0;

  if (l.length > 3) {
    for (int i = 3; i < l.length; i++) {
      final sd = l[i].shareDetail?.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);
      if (sd != null) {
        ordinaryTotalOtherShare += sd.numberOfShares;
      }
    }
    final sd1 = l[0].shareDetail?.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);
    final sd2 = l[1].shareDetail?.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);
    final sd3 = l[2].shareDetail?.firstWhereOrNull((sd) => sd.shareTypeId == shareTypeId);
    if (sd1 != null && sd2 != null && sd3 != null) {
      final sh4 = Shareholder();
      sh4.name = sh4.firstName = "Other ${l.length - 3} Shareholder(s)";
      sh4.shareholderType = "individual";
      final osd = ShareDetail.empty();
      osd.shareTypeId = shareTypeId;
      osd.numberOfShares = ordinaryTotalOtherShare as int;
      osd.percent = ordinaryTotalOtherShare / totalShare;
      sh4.shareDetail = [osd];
      l2 = [l[0], l[1], l[2], sh4]; //
    }
  } else {
    l2 = l;
  }

  return l2;
}

num getPaidUpCapital(List<ShareCapital> shareCapital, {String shareTypeId = "ordinary-sgd"}) {
  num paidUpCapital = 0;
  try {
    for (var o in shareCapital) {
      if (o.shareTypeId == shareTypeId) {
        paidUpCapital += o.paidUpCapital;
      }
    }
  } catch (e) {
    Utils.err("shareCapital error: $e");
  }
  return paidUpCapital;
}

num calculateTotalShare(List<Shareholder> l, {String shareTypeId = "ordinary-sgd"}) {
  num s = 0;
  for (var o in l) {
    final shareDetails = o.shareDetail;
    shareDetails?.forEach((o2) {
      if (o2.shareTypeId == shareTypeId) {
        s += o2.numberOfShares;
      }
    });
  }

  return s;
}

num getFullDilutedShares(List<Shareholder> l) {
  num totalShare = 0;
  try {
    for (var sh in l) {
      for (var sd in sh.shareDetail ?? []) {
        totalShare += sd.numberOfShares;
      }
    }
  } catch (e) {
    Utils.err("getFullDilutedShares error: $e");
  }
  return totalShare;
}

List<dynamic> getAmountRaised(List<ShareCapital> l) {
  final ar = [];
  final uniqCurrency = l.map((e) => e.currency).toSet();
  for (var c in uniqCurrency) {
    num totalAmtCurrency = 0;
    for (var o in l) {
      if (o.currency == c) {
        totalAmtCurrency += o.paidUpCapital;
      }
    }
    ar.add({"currency": c, "amount": totalAmtCurrency});
  }
  return ar;
}

List<dynamic> getShareNumPerType(List<ShareCapital> l, List<Shareholder> l2) {
  final ar = [];
  final uniqShareType = l.map((e) => e.shareType).toSet();
  for (var s in uniqShareType) {
    num totalAmtShare = 0;
    for (var o in l2) {
      final l3 = o.shareDetail ?? [];
      for (var sd in l3) {
        if (sd.shareType == s) {
          totalAmtShare += sd.numberOfShares;
        }
      }
    }
    ar.add({"shareType": s, "amount": totalAmtShare});
  }
  return ar;
}

List<dynamic> getAmountRaisedPerShareType(List<ShareCapital> l) {
  final ar = [];
  final uniqShareType = l.map((e) => e.shareType).toSet();
  for (var s in uniqShareType) {
    num totalAmtShareType = 0;
    for (var o in l) {
      if (o.shareType == s) {
        totalAmtShareType += o.paidUpCapital;
      }
    }
    ar.add({"shareType": s, "amount": totalAmtShareType});
  }
  return ar;
}

ShareDetail? getShareholderShare(List<Shareholder>? l, referenceId, [String shareTypeId = "ordinary-sgd"]) {
  final s = l?.firstWhere((sh) => sh.referenceId == referenceId);
  final sd = s?.shareDetail?.firstWhere((sd) => sd.shareType == shareTypeId);

  return sd;
}
