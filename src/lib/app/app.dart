import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:m360_app_corpsec/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:m360_app_corpsec/ui/views/_startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:m360_app_corpsec/services/authentication_service.dart';
import 'package:m360_app_corpsec/services/share_service.dart';
import 'package:m360_app_corpsec/ui/views/login/login_view.dart';
import 'package:m360_app_corpsec/ui/views/sign_up/sign_up_view.dart';
import 'package:m360_app_corpsec/ui/views/dashboard/dashboard_view.dart';
import 'package:m360_app_corpsec/ui/dialogs/company_selector/company_selector_dialog.dart';
import 'package:m360_app_corpsec/ui/views/company/company_view.dart';
import 'package:m360_app_corpsec/ui/views/request/request_view.dart';
import 'package:m360_app_corpsec/ui/views/document/document_view.dart';
import 'package:m360_app_corpsec/ui/views/timeline/timeline_view.dart';
import 'package:m360_app_corpsec/ui/dialogs/confirmation/confirmation_dialog.dart';
import 'package:m360_app_corpsec/services/company_service.dart';
import 'package:m360_app_corpsec/ui/views/dev_debug/dev_debug_view.dart';
import 'package:m360_app_corpsec/ui/bottom_sheets/member_detail/member_detail_sheet.dart';
import 'package:m360_app_corpsec/ui/bottom_sheets/shareholder_detail/shareholder_detail_sheet.dart';
import 'package:m360_app_corpsec/ui/views/document_detail/document_detail_view.dart';
import 'package:m360_app_corpsec/ui/views/account/account_view.dart';
import 'package:m360_app_corpsec/ui/dialogs/about_us/about_us_dialog.dart';
import 'package:m360_app_corpsec/ui/bottom_sheets/about_us/about_us_sheet.dart';
import 'package:m360_app_corpsec/ui/dialogs/biometric_login/biometric_login_dialog.dart';
import 'package:m360_app_corpsec/ui/views/biometric_preference/biometric_preference_view.dart';
import 'package:m360_app_corpsec/services/business_central_service.dart';
import 'package:m360_app_corpsec/ui/views/sales_invoice/sales_invoice_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    CustomRoute(page: DashboardView, transitionsBuilder: TransitionsBuilders.fadeIn),
    MaterialRoute(page: CompanyView),
    MaterialRoute(page: RequestView),
    MaterialRoute(page: DocumentView),
    MaterialRoute(page: TimelineView),
    MaterialRoute(page: DevDebugView),
    MaterialRoute(page: DocumentDetailView),
    MaterialRoute(page: AccountView),
    CustomRoute(
      page: BiometricPreferenceView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    MaterialRoute(page: SalesInvoiceView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: ShareService),
    LazySingleton(classType: CompanyService),
    LazySingleton(classType: BusinessCentralService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: MemberDetailSheet),
    StackedBottomsheet(classType: ShareholderDetailSheet),
    StackedBottomsheet(classType: AboutUsSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: CompanySelectorDialog),
    StackedDialog(classType: ConfirmationDialog),
    StackedDialog(classType: AboutUsDialog),
    StackedDialog(classType: BiometricLoginDialog),
// @stacked-dialog
  ],
)
class App {}
