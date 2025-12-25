// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/about_us/about_us_dialog.dart';
import '../ui/dialogs/biometric_login/biometric_login_dialog.dart';
import '../ui/dialogs/company_selector/company_selector_dialog.dart';
import '../ui/dialogs/confirmation/confirmation_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';

enum DialogType {
  infoAlert,
  companySelector,
  confirmation,
  aboutUs,
  biometricLogin,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) => InfoAlertDialog(request: request, completer: completer),
    DialogType.companySelector: (context, request, completer) =>
        CompanySelectorDialog(request: request, completer: completer),
    DialogType.confirmation: (context, request, completer) =>
        ConfirmationDialog(request: request, completer: completer),
    DialogType.aboutUs: (context, request, completer) => AboutUsDialog(request: request, completer: completer),
    DialogType.biometricLogin: (context, request, completer) =>
        BiometricLoginDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
