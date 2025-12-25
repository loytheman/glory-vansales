import 'package:skeletonizer/skeletonizer.dart';

class Company {
  late String? id;
  late String? organizationId;
  late String? registeredNumber;
  late String? entityName;
  late String? riskAssessmentRating;
  late String? legislationEntityName;
  late String? commonSeal;
  late String? companyStamp;
  late String? companyName;
  late String? formerName;
  late String? nameEffectiveDate;
  late String? incorporationDate;
  late String? companyType;
  late String? companyStructureType;
  late String? companyStatus;
  late String? countryOfIncorporation;
  late String? firstFinancialYearEndDate;
  late String? nextFinancialYearEndDate;
  late int financialYearPeriod;
  late String? lastAnnualGeneralMeeting;
  late String? lastAnnualReturns;
  late String? kybStatus;
  late String? kybStage;
  late String? kybPassedAt;
  late String? status;

  late Map<String, dynamic>? companyActivity;
  late Address? registeredAddress;
  late Address? businessOpAddress;
  late List<Member>? members;
  late List<ShareCapital>? shareCapital;
  late List<Shareholder>? shareholders;

  late List<String>? fileOrder;

  Company();

  factory Company.fromMock() {
    final c = Company();
    c.companyName = BoneMock.chars(48, "-");
    c.registeredNumber = BoneMock.chars(48, "-");
    c.companyActivity = {"activity1": CompanyActivity.fromMock(), "activity2": CompanyActivity.fromMock()};
    c.nextFinancialYearEndDate = "1960-01-01";
    // c.lastAnnualGeneralMeeting = "1960-01-01";
    c.lastAnnualGeneralMeeting = null;
    return c;
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    final c = Company();
    final d = json;

    c.id = d["id"];
    c.organizationId = d["organizationId"];
    c.registeredNumber = d["registeredNumber"];
    c.entityName = d["entityName"];
    c.riskAssessmentRating = d["riskAssessmentRating"];
    c.legislationEntityName = d["legislationEntityName"];
    c.commonSeal = d["commonSeal"];
    c.companyStamp = d["companyStamp"];
    c.companyName = d["companyName"];
    c.formerName = d["formerName"];
    c.nameEffectiveDate = d["nameEffectiveDate"];
    c.incorporationDate = d["incorporationDate"];
    c.companyType = d["companyType"];
    c.companyStructureType = d["companyStructureType"];
    c.companyStatus = d["companyStatus"];
    c.countryOfIncorporation = d["countryOfIncorporation"];
    c.firstFinancialYearEndDate = d["firstFinancialYearEndDate"];
    c.nextFinancialYearEndDate = d["nextFinancialYearEndDate"];
    c.financialYearPeriod = d["financialYearPeriod"] ?? 2042;
    c.lastAnnualGeneralMeeting = d["lastAnnualGeneralMeeting"];
    c.lastAnnualReturns = d["lastAnnualReturns"];
    c.kybStatus = d["kybStatus"];
    c.kybStage = d["kybStage"];
    c.kybPassedAt = d["kybPassedAt"];
    c.status = d["status"];

    c.companyActivity = d["companyActivity"];
    if (c.companyActivity != null) {
      c.companyActivity?["activity1"] = CompanyActivity.fromJson(d["companyActivity"]["activity1"]);
      c.companyActivity?["activity2"] = CompanyActivity.fromJson(d["companyActivity"]["activity2"]);
    }

    c.registeredAddress = Address.fromJson(d["registeredAddress"]);
    c.businessOpAddress = Address.fromJson(d["businessOpAddress"]);

    if (d["members"] != null) {
      c.members = Member.listFromJson(d["members"]);
    }
    if (d["shareCapital"] != null) {
      c.shareCapital = ShareCapital.listFromJson(d["shareCapital"]);
    }
    c.shareholders = Shareholder.listFromJson(d["shareholders"]);

    final fo = d["fileOrder"];
    if (fo != null) {
      c.fileOrder = fo.cast<String>();
    }

    // c.fileOrder = (jsonDecode(d["fileOrder"]) as List<dynamic>).cast<String>() ?? [];

    return c;
  }
  @override
  String toString() {
    return "\n> Company: ($id, $companyName, $shareholders, $shareholders)";
  }
}

class CompanyActivity {
  late String? code;
  late String? title;
  late String? description;

  CompanyActivity();

  factory CompanyActivity.fromMock() {
    final c = CompanyActivity();
    c.code = BoneMock.chars(12, "-");
    c.title = BoneMock.chars(48, "-");
    c.description = BoneMock.chars(128, "-");

    return c;
  }

  factory CompanyActivity.fromJson(Map<String, dynamic> json) {
    final c = CompanyActivity();
    final d = json;
    c.code = d["code"];
    c.title = d["title"];
    c.description = d["description"];

    return c;
  }
}

class Address {
  late String? address1;
  late String? address2;
  late String? postcode;
  late String? country;

  Address();

  factory Address.fromJson(Map<String, dynamic> json) {
    final c = Address();
    final d = json;
    c.address1 = d["address1"];
    c.address2 = d["address2"];
    c.postcode = d["postcode"];
    c.country = d["country"];
    return c;
  }

  bool isNotEmpty() {
    return address1?.isNotEmpty ?? false;
  }

  @override
  String toString() {
    return "$address1 $address2 $postcode $country";
  }
}

class Member {
  late String? memberType;
  late String? memberRole;
  late String? cessationType;
  late String? appointmentDate;
  late String? cessationDate;
  late String? referenceId;
  late String? name;
  //late String? internalNote;
  //individual
  late String? firstName;
  late String? lastName;
  late String? idNo;
  late String? address1;
  late String? postcode;
  late String? country;
  //company
  late String? companyName;
  late String? registeredNumber;
  late Address? registeredAddress;

  Member();

  factory Member.fromJson(Map<String, dynamic> json) {
    final c = Member();
    final d = json;
    c.memberType = d["memberType"];
    c.memberRole = d["memberRole"];
    c.cessationType = d["cessationType"];
    c.appointmentDate = d["appointmentDate"];
    c.cessationDate = d["cessationDate"];
    c.referenceId = d["referenceId"];
    //c.internalNote = d["internalNote"];

    if (c.memberType == "individual") {
      c.firstName = d["firstName"];
      c.lastName = d["lastName"];
      c.idNo = d["idNo"];
      c.address1 = d["address1"];
      c.postcode = d["postcode"];
      c.country = d["country"];
      c.name = c.firstName != null ? "${c.firstName} ${c.lastName}" : "---";
    } else if (c.memberType == "company") {
      c.companyName = d["companyName"];
      c.registeredNumber = d["registeredNumber"];
      if (d["registeredAddress"] != null) {
        c.registeredAddress = Address.fromJson(d["registeredAddress"]);
      }
      c.name = c.companyName ?? "---";
    }

    //c.memberRole = c.memberRole?.toUpperCase();

    return c;
  }

  static List<Member> listFromJson(List<dynamic> json) {
    final l = json.where((x) => x != null && x is Map<String, dynamic>).map((d) => Member.fromJson(d)).toList();
    return l;
  }
}

class ShareCapital {
  late double amountOfCapital;
  late double paidUpCapital;
  late String? currency;
  late String? shareType;
  late String shareTypeId;

  ShareCapital();

  factory ShareCapital.fromJson(Map<String, dynamic> json) {
    final c = ShareCapital();
    final d = json;

    c.amountOfCapital = (d["amountOfCapital"] ?? 0) + 0.0;
    c.paidUpCapital = (d["paidUpCapital"] ?? 0) + 0.0;
    c.currency = d["currency"];
    c.shareType = d["shareType"];
    c.shareTypeId = "${c.shareType}-${c.currency}";

    return c;
  }

  static List<ShareCapital> listFromJson(List<dynamic> json) {
    final l = json.where((x) => x != null && x is Map<String, dynamic>).map((d) => ShareCapital.fromJson(d)).toList();
    return l;
  }

  @override
  String toString() {
    return "\n > ShareCapital: ($amountOfCapital, $paidUpCapital, $currency, $shareType, $shareTypeId)";
  }
}

class Shareholder {
  late List<ShareDetail>? shareDetail;
  late String referenceId;
  late String shareholderType;
  late String name;
  //individual
  String? firstName;
  String? lastName;
  String? idNo;
  String? address1;
  String? postcode;
  String? country;
  //company
  String? companyName;
  String? registeredNumber;
  Address? registeredAddress;

  Shareholder();

  factory Shareholder.fromJson(Map<String, dynamic> json) {
    final c = Shareholder();
    final d = json;
    c.shareholderType = d["shareholderType"];
    c.referenceId = d["referenceId"];
    c.shareDetail = ShareDetail.listFromJson(d["shareDetail"]);

    if (c.shareholderType == "individual") {
      c.firstName = d["firstName"];
      c.lastName = d["lastName"];
      c.idNo = d["idNo"];
      c.address1 = d["address1"];
      c.postcode = d["postcode"];
      c.country = d["country"];
      c.name = c.firstName != null ? "${c.firstName ?? ''} ${c.lastName ?? ''}" : "---";
    } else if (c.shareholderType == "company") {
      c.companyName = d["companyName"];
      c.registeredNumber = d["registeredNumber"];
      c.registeredAddress = Address.fromJson(d["registeredAddress"]);
      c.name = c.companyName ?? "---";
    }
    return c;
  }

  Shareholder clone() {
    final c = Shareholder();
    c.shareholderType = shareholderType;
    c.referenceId = referenceId;
    c.shareDetail = shareDetail;
    c.name = name;
    if (c.shareholderType == "individual") {
      c.firstName = firstName;
      c.lastName = lastName;
      c.idNo = idNo;
      c.address1 = address1;
      c.postcode = postcode;
      c.country = country;
    } else if (c.shareholderType == "company") {
      c.companyName = companyName;
      c.registeredNumber = registeredNumber;
      c.registeredAddress = registeredAddress;
    }
    return c;
  }

  static List<Shareholder> listFromJson(List<dynamic> json) {
    final l = json.where((x) => x != null && x is Map<String, dynamic>).map((d) => Shareholder.fromJson(d)).toList();
    return l;
  }

  @override
  String toString() {
    return "\n > Shareholder: ($shareholderType, $referenceId, $shareDetail)";
  }
}

class ShareDetail {
  late String shareType;
  late String currency;
  late int numberOfShares;
  late String shareTypeId;
  num? percent;
  num? capital;

  ShareDetail({required this.shareType, required this.currency, required this.numberOfShares})
      : shareTypeId = "$shareType-$currency";

  factory ShareDetail.empty() {
    final c = ShareDetail(shareType: "individual", currency: "sgd", numberOfShares: 0);
    return c;
  }

  factory ShareDetail.fromJson(Map<String, dynamic> json) {
    final d = json;
    final c = ShareDetail(shareType: d["shareType"], currency: d["currency"], numberOfShares: d["numberOfShares"]);
    // c.shareType = d["shareType"];
    // c.currency = d["currency"];
    // c.numberOfShares = d["numberOfShares"] ?? 0;
    c.shareTypeId = "${c.shareType}-${c.currency}";

    return c;
  }

  static List<ShareDetail> listFromJson(List<dynamic> json) {
    final l = json.where((x) => x != null && x is Map<String, dynamic>).map((d) => ShareDetail.fromJson(d)).toList();
    return l;
  }

  @override
  String toString() {
    return "\n> ShareDetail: ($shareTypeId, $numberOfShares, $percent)";
  }
}

class Timeline {
  late String eventId;
  late String organizationId;
  late String companyId;
  late String eventTitle;
  late String eventDate;
  late String eventDescription;
  late String eventStatus;

  Timeline();

  factory Timeline.fromJson(Map<String, dynamic> json) {
    final c = Timeline();
    final d = json;
    c.eventDate = d["eventDate"];
    c.eventTitle = d["eventTitle"];
    c.eventDescription = d["eventDescription"];

    return c;
  }
}

class Document {
  late String id;
  late String organizationId;
  late String fileName;
  late String companyId;
  late List<String> labels;
  late FileLocation fileLocation;
  late String documentStatus;
  late String lastAccessed;
  late String status;
  late String createdAt;
  late String updatedAt;
  late String url;
  late String sessionAccessToken;

  Document();

  factory Document.fromJson(Map<String, dynamic> json) {
    final c = Document();
    final d = json;
    c.id = d["id"];
    c.organizationId = d["organizationId"];
    c.fileName = d["fileName"];
    c.companyId = d["companyId"];
    //c.labels = d["labels"] as List<String>;
    c.labels = (List<String>.from(d["labels"].map((x) => x as String)));
    c.fileLocation = FileLocation.fromJson(d["fileLocation"]);
    c.documentStatus = d["documentStatus"];
    c.lastAccessed = d["lastAccessed"];
    c.status = d["status"];
    c.createdAt = d["createdAt"];
    c.updatedAt = d["updatedAt"];
    c.url = d["url"];
    c.sessionAccessToken = d["sessionAccessToken"];
    return c;
  }

  static List<Document> listFromJson(List<dynamic> json) {
    final l = json.where((x) => x != null && x is Map<String, dynamic>).map((d) => Document.fromJson(d)).toList();
    return l;
  }
}

class FileLocation {
  late String baseUrl;
  late String path;

  FileLocation();

  factory FileLocation.fromJson(Map<String, dynamic> json) {
    final c = FileLocation();
    final d = json;
    c.baseUrl = d["baseUrl"];
    c.path = d["path"];

    return c;
  }
}
