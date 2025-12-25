import 'package:m360_app_corpsec/helpers/mixins.dart';
import 'package:m360_app_corpsec/helpers/store.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/services/_webapi.dart';
import 'package:stacked/stacked.dart';

class CompanyService with ApiServiceMixin, ListenableServiceMixin {
  Company? currentCompany;
  List<Company> companyArr = [];
  //List<Timeline> timeline = [];

  CompanyService() {
    listenToReactiveValues([currentCompany]);
  }

  Future<void> setCurrentCompany({String? companyId, Company? company}) async {
    Utils.log("setCurrentCompany : $companyId");
    Company? c;
    try {
      if (companyId != null) {
        c = companyArr.firstWhere((c) => c.id == companyId);
        //timeline = await getDashboardTimeline(companyId);
      } else if (company != null) {
        c = company;
      }
      await StoreHelper.writePrefCompany(c!);
      currentCompany = c;
    } catch (e) {
      Utils.log("setCurrentCompany error $e");
    }
    notifyListeners();
  }

  Future<Company?> getCompany(String id) async {
    Company? c;
    try {
      final ar = await WebApi.callApi("GET", '/companies/$id');
      final d = ar.data;
      c = Company.fromJson(d);
    } catch (e) {
      Utils.err("getCompany : $e");
    }

    return c;
  }

  Future<List<Company>> getAllCompany() async {
    List<Company> l = [];
    try {
      final ar = await WebApi.callApi("GET", '/companies');
      final d = ar.data;
      l = (List<Company>.from(d.map((x) => Company.fromJson(x))));
      companyArr = l;
    } catch (e) {
      // ShareFunc.showToast(e.toString());
      Utils.err("getCompanies : $e");
    }

    return l;
  }

  Future<List<Timeline>> getDashboardTimeline(String id) async {
    List<Timeline> l = [];
    try {
      final ar = await WebApi.callApi("GET", '/timelines/company/$id');
      final d = ar.data;
      l = (List<Timeline>.from(d.map((x) => Timeline.fromJson(x))));
    } catch (e) {
      // ShareFunc.showToast(e.toString());
      Utils.err("getDashboardTimeline : $e");
    }

    return l;
  }

  Future<List<Document>> getDocuments(String companyId) async {
    List<Document> l = [];
    try {
      final ar = await WebApi.callApi("GET", '/documents/company/$companyId');
      final d = ar.data;
      l = (List<Document>.from(d.map((x) => Document.fromJson(x))));
    } catch (e) {
      // ShareFunc.showToast(e.toString());
      Utils.err("getDocuments : $e");
    }

    return l;
  }

  // Future<Null> getDocumentById(String companyId, String documentId) async {
  //   List<Timeline> l = [];
  //   try {
  //     final ar = await WebApi.callApi("GET", '/documents/$documentId');
  //     //final d = ar.data;
  //     //l = (List<Timeline>.from(d.map((x) => Timeline.fromJson(x))));
  //   } catch (e) {
  //     // ShareFunc.showToast(e.toString());
  //     Utils.err("getDocumentById : $e");
  //   }

  //   return null;
  //   //return l;
  // }

  String getPreviewCompanyDocumentUrl(String key, String sessionAccessToken) {
    //final url = "${u}/site/preview/${key}?token=${token}";
    final url = "${WebApi.baseUrl}/site/preview/$key?token=$sessionAccessToken";
    return url;
  }
}
