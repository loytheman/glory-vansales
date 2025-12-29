import 'package:flutter/material.dart';
import 'package:glory_vansales_app/app/app.bottomsheets.dart';
import 'package:glory_vansales_app/app/app.dialogs.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/common/config.dart';
import 'package:glory_vansales_app/common/theme.dart';
import 'package:glory_vansales_app/helpers/deep_link.dart';
import 'package:glory_vansales_app/helpers/life_cycle.dart';
import 'package:glory_vansales_app/helpers/push.dart';
import 'package:glory_vansales_app/services/_webapi.dart';
import 'package:glory_vansales_app/ui/views/_layout_inactive_wrapper.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  //const mode = String.fromEnvironment('MODE', defaultValue: 'not set');
  const mode = "stg";
  Config.initMode(mode);
  Config.debug();
  WebApi.init();
  LifeCycleHelper.init();

  WidgetsFlutterBinding.ensureInitialized();
  // await StoreHelper.clearStorage();
  await setupLocator();

  await PushHelper.init();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(const MainApp());
  // runApp(LifeCycleBlurWrapper(child: const MainApp()));1

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
      onGenerateRoute: StackedRouter().onGenerateRoute,
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
