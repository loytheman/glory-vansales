// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i17;
import 'package:flutter/material.dart';
import 'package:m360_app_central/ui/views/profile/profile_view.dart' as _i13;
import 'package:m360_app_central/ui/views/test/test_view.dart' as _i14;
import 'package:m360_app_corpsec/models/model.account.dart' as _i18;
import 'package:m360_app_corpsec/ui/views/_startup/startup_view.dart' as _i2;
import 'package:m360_app_corpsec/ui/views/account/account_view.dart' as _i12;
import 'package:m360_app_corpsec/ui/views/biometric_preference/biometric_preference_view.dart'
    as _i15;
import 'package:m360_app_corpsec/ui/views/central/central_view.dart' as _i16;
import 'package:m360_app_corpsec/ui/views/company/company_view.dart' as _i6;
import 'package:m360_app_corpsec/ui/views/dashboard/dashboard_view.dart' as _i5;
import 'package:m360_app_corpsec/ui/views/dev_debug/dev_debug_view.dart'
    as _i10;
import 'package:m360_app_corpsec/ui/views/document/document_view.dart' as _i8;
import 'package:m360_app_corpsec/ui/views/document_detail/document_detail_view.dart'
    as _i11;
import 'package:m360_app_corpsec/ui/views/login/login_view.dart' as _i3;
import 'package:m360_app_corpsec/ui/views/request/request_view.dart' as _i7;
import 'package:m360_app_corpsec/ui/views/sign_up/sign_up_view.dart' as _i4;
import 'package:m360_app_corpsec/ui/views/timeline/timeline_view.dart' as _i9;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i19;

class Routes {
  static const startupView = '/startup-view';

  static const loginView = '/login-view';

  static const signUpView = '/sign-up-view';

  static const dashboardView = '/dashboard-view';

  static const companyView = '/company-view';

  static const requestView = '/request-view';

  static const documentView = '/document-view';

  static const timelineView = '/timeline-view';

  static const devDebugView = '/dev-debug-view';

  static const documentDetailView = '/document-detail-view';

  static const accountView = '/account-view';

  static const profileView = '/profile-view';

  static const testView = '/test-view';

  static const biometricPreferenceView = '/biometric-preference-view';

  static const centralView = '/central-view';

  static const all = <String>{
    startupView,
    loginView,
    signUpView,
    dashboardView,
    companyView,
    requestView,
    documentView,
    timelineView,
    devDebugView,
    documentDetailView,
    accountView,
    profileView,
    testView,
    biometricPreferenceView,
    centralView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i4.SignUpView,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i5.DashboardView,
    ),
    _i1.RouteDef(
      Routes.companyView,
      page: _i6.CompanyView,
    ),
    _i1.RouteDef(
      Routes.requestView,
      page: _i7.RequestView,
    ),
    _i1.RouteDef(
      Routes.documentView,
      page: _i8.DocumentView,
    ),
    _i1.RouteDef(
      Routes.timelineView,
      page: _i9.TimelineView,
    ),
    _i1.RouteDef(
      Routes.devDebugView,
      page: _i10.DevDebugView,
    ),
    _i1.RouteDef(
      Routes.documentDetailView,
      page: _i11.DocumentDetailView,
    ),
    _i1.RouteDef(
      Routes.accountView,
      page: _i12.AccountView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i13.ProfileView,
    ),
    _i1.RouteDef(
      Routes.testView,
      page: _i14.TestView,
    ),
    _i1.RouteDef(
      Routes.biometricPreferenceView,
      page: _i15.BiometricPreferenceView,
    ),
    _i1.RouteDef(
      Routes.centralView,
      page: _i16.CentralView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      final args = data.getArgs<StartupViewArguments>(
        orElse: () => const StartupViewArguments(),
      );
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.StartupView(key: args.key, tokenSet: args.tokenSet),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.LoginView(
            key: args.key, useBiometricFlag: args.useBiometricFlag),
        settings: data,
      );
    },
    _i4.SignUpView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SignUpView(),
        settings: data,
      );
    },
    _i5.DashboardView: (data) {
      return _i17.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i5.DashboardView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.fadeIn,
      );
    },
    _i6.CompanyView: (data) {
      final args = data.getArgs<CompanyViewArguments>(
        orElse: () => const CompanyViewArguments(),
      );
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.CompanyView(key: args.key, tabIndex: args.tabIndex),
        settings: data,
      );
    },
    _i7.RequestView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.RequestView(),
        settings: data,
      );
    },
    _i8.DocumentView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.DocumentView(),
        settings: data,
      );
    },
    _i9.TimelineView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.TimelineView(),
        settings: data,
      );
    },
    _i10.DevDebugView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.DevDebugView(),
        settings: data,
      );
    },
    _i11.DocumentDetailView: (data) {
      final args = data.getArgs<DocumentDetailViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.DocumentDetailView(
            key: args.key, filename: args.filename, path: args.path),
        settings: data,
      );
    },
    _i12.AccountView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.AccountView(),
        settings: data,
      );
    },
    _i13.ProfileView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.ProfileView(),
        settings: data,
      );
    },
    _i14.TestView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.TestView(),
        settings: data,
      );
    },
    _i15.BiometricPreferenceView: (data) {
      return _i17.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i15.BiometricPreferenceView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.fadeIn,
      );
    },
    _i16.CentralView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.CentralView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class StartupViewArguments {
  const StartupViewArguments({
    this.key,
    this.tokenSet,
  });

  final _i17.Key? key;

  final _i18.TokenSet? tokenSet;

  @override
  String toString() {
    return '{"key": "$key", "tokenSet": "$tokenSet"}';
  }

  @override
  bool operator ==(covariant StartupViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.tokenSet == tokenSet;
  }

  @override
  int get hashCode {
    return key.hashCode ^ tokenSet.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({
    this.key,
    this.useBiometricFlag,
  });

  final _i17.Key? key;

  final bool? useBiometricFlag;

  @override
  String toString() {
    return '{"key": "$key", "useBiometricFlag": "$useBiometricFlag"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.useBiometricFlag == useBiometricFlag;
  }

  @override
  int get hashCode {
    return key.hashCode ^ useBiometricFlag.hashCode;
  }
}

class CompanyViewArguments {
  const CompanyViewArguments({
    this.key,
    this.tabIndex,
  });

  final _i17.Key? key;

  final int? tabIndex;

  @override
  String toString() {
    return '{"key": "$key", "tabIndex": "$tabIndex"}';
  }

  @override
  bool operator ==(covariant CompanyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.tabIndex == tabIndex;
  }

  @override
  int get hashCode {
    return key.hashCode ^ tabIndex.hashCode;
  }
}

class DocumentDetailViewArguments {
  const DocumentDetailViewArguments({
    this.key,
    required this.filename,
    required this.path,
  });

  final _i17.Key? key;

  final String filename;

  final String path;

  @override
  String toString() {
    return '{"key": "$key", "filename": "$filename", "path": "$path"}';
  }

  @override
  bool operator ==(covariant DocumentDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.filename == filename && other.path == path;
  }

  @override
  int get hashCode {
    return key.hashCode ^ filename.hashCode ^ path.hashCode;
  }
}

extension NavigatorStateExtension on _i19.NavigationService {
  Future<dynamic> navigateToStartupView({
    _i17.Key? key,
    _i18.TokenSet? tokenSet,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.startupView,
        arguments: StartupViewArguments(key: key, tokenSet: tokenSet),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView({
    _i17.Key? key,
    bool? useBiometricFlag,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments:
            LoginViewArguments(key: key, useBiometricFlag: useBiometricFlag),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCompanyView({
    _i17.Key? key,
    int? tabIndex,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.companyView,
        arguments: CompanyViewArguments(key: key, tabIndex: tabIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRequestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.requestView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDocumentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.documentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTimelineView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.timelineView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDevDebugView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.devDebugView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDocumentDetailView({
    _i17.Key? key,
    required String filename,
    required String path,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.documentDetailView,
        arguments: DocumentDetailViewArguments(
            key: key, filename: filename, path: path),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.testView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBiometricPreferenceView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.biometricPreferenceView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCentralView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.centralView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView({
    _i17.Key? key,
    _i18.TokenSet? tokenSet,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.startupView,
        arguments: StartupViewArguments(key: key, tokenSet: tokenSet),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    _i17.Key? key,
    bool? useBiometricFlag,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
        arguments:
            LoginViewArguments(key: key, useBiometricFlag: useBiometricFlag),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCompanyView({
    _i17.Key? key,
    int? tabIndex,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.companyView,
        arguments: CompanyViewArguments(key: key, tabIndex: tabIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRequestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.requestView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDocumentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.documentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTimelineView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.timelineView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDevDebugView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.devDebugView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDocumentDetailView({
    _i17.Key? key,
    required String filename,
    required String path,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.documentDetailView,
        arguments: DocumentDetailViewArguments(
            key: key, filename: filename, path: path),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.accountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.testView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBiometricPreferenceView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.biometricPreferenceView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCentralView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.centralView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
