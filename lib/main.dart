import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/app/app.bottomsheets.dart';
import 'package:m360_app_corpsec/app/app.dialogs.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/app/combined_app.dart';
import 'package:m360_app_corpsec/app/combined_router.dart';
import 'package:m360_app_corpsec/common/config.dart';
import 'package:m360_app_corpsec/common/theme.dart';
import 'package:m360_app_corpsec/helpers/deep_link.dart';
import 'package:m360_app_corpsec/helpers/life_cycle.dart';
import 'package:m360_app_corpsec/helpers/push.dart';
import 'package:m360_app_corpsec/services/_webapi.dart';
import 'package:m360_app_corpsec/ui/views/_layout_inactive_wrapper.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:m360_app_central/main.dart' as central;

Future<void> reInitRoot() async {
  // done run the locator in main when start the root app
  // routes, dialog ui, botoom sheet ui need to re-init due to the scope effect
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

Future<void> main() async {
  // StackedLocator.instance.pushNewScope(scopeName: 'root');
  //const mode = String.fromEnvironment('MODE', defaultValue: 'not set');
  const mode = "stg";
  Config.initMode(mode);
  Config.debug();
  WebApi.init();
  LifeCycleHelper.init();

  // await StoreHelper.clearStorage();

  // WidgetsFlutterBinding.ensureInitialized();
  // await setupLocator();
  // setupDialogUi();
  // setupBottomSheetUi();
  await setupApp();

  await PushHelper.init();

  runApp(const MainApp());
  DeepLinkHelper.init();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final t = MaterialApp(
      title: "MEYZER360",
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      initialRoute: Routes.startupView,
      onGenerateRoute: CombinedRouter().onGenerateRoute,
      // onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      // Wrap the app's routes with LifeCycleBlurWrapper using the builder.
      builder: (context, child) => LifeCycleBlurWrapper(child: child!),
    );

    return t;
  }
}
