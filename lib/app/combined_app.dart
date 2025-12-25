import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

// *** ROOT APP IMPORTS ***
import 'package:m360_app_corpsec/app/app.locator.dart' as rootLocator;
import 'package:m360_app_corpsec/app/app.dialogs.dart' as rootDialogs;
import 'package:m360_app_corpsec/app/app.bottomsheets.dart' as rootSheets;

// *** CENTRAL MODULE IMPORTS ***
import 'package:m360_app_central/app/app.locator.dart' as centralLocator;
import 'package:m360_app_central/app/app.dialogs.dart' as centralDialogs;
import 'package:m360_app_central/app/app.bottomsheets.dart' as centralSheets;

Future<void> setupApp() async {
  // ensure binding is initialized before any native calls
  WidgetsFlutterBinding.ensureInitialized();

  await rootLocator.setupLocator();

  /**
   * Enable reassignment so that modules can override or re-register
   * services as needed, and avoid conflicts with the default service
   * locators (bottom sheet, dialog, navigation).
   *
   * To prevent name collisions, use a consistent naming convention—
   * for example, prefix your services with the module name:
   *   rootTestService
   * or supply an instanceName:
   *   LazySingleton(
   *     classType: TestService,
   *     instanceName: 'root',
   *   );
   */

  GetIt.instance.allowReassignment = true;

  await centralLocator.setupLocator();

  GetIt.instance.allowReassignment = false;

  // Wire up dialog & bottom‐sheet UI builders
  rootDialogs.setupDialogUi();
  rootSheets.setupBottomSheetUi();

  centralDialogs.setupDialogUi();
  centralSheets.setupBottomSheetUi();

  // Optional: if you prefer to swallow duplicate-registration errors instead of
  // toggling allowReassignment, you could wrap the module setup in a try/catch:
  //
  // try {
  //   await centralLocator.setupLocator();
  // } catch (e) {
  //   // e.g. “Type X is already registered” → ignore and continue
  // }
}
