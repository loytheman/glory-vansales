import 'package:flutter/material.dart';
import 'package:m360_app_central/app/app.locator.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'central_viewmodel.dart';
import 'package:m360_app_central/main.dart' as central;
import 'package:m360_app_central/app/app.router.dart' as central_router;

class CentralView extends StackedView<CentralViewModel> {
  const CentralView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(CentralViewModel viewModel) async {
    viewModel.init();
  }

  @override
  Widget builder(
    BuildContext context,
    CentralViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        child: Center(
            child: Column(
          children: [
            MyUi.hs_md(),
            MyUi.hs_md(),
            Text("Parent Central View"),
            ElevatedButton(
                onPressed: () {
                 viewModel.toTimeline();
                },
                child: Text('To Timeline')),
            MyUi.hs_md(),
            ElevatedButton(
                onPressed: () {
                 viewModel.showCompanySelector();
                },
                child: Text('Company Selector')),
            MyUi.hs_md(),
            ElevatedButton(
                onPressed: () {
                 viewModel.showDialog();
                },
                child: Text('Dialog Info Alert')),
            MyUi.hs_md(),
            MyUi.hs_md(),
            ElevatedButton(
                onPressed: () {
                 viewModel.testService();
                },
                child: Text('Test Service')),
            MyUi.hs_md(),
            // central.MainApp() <-- got duplicate stackedservice issue
            if (!viewModel.vmBusy)
              // navigator <-- work on single page but doesnt tackle other child page dispose and change scope issue
              Expanded(
                child: Navigator(
                    // key: locator<NavigationService>().navigatorKey,
                    initialRoute: central_router.Routes.testView,
                    onGenerateRoute:
                        central_router.StackedRouter().onGenerateRoute,
                    observers: [RouteObserver<PageRoute>()]),
              )
          ],
        )),
      ),
      // body: IndexedStack(
      //     index: 0,
      //     children: List.generate(central_router.Routes.all.length, (i) {
      //       // Each Navigator gets its own key:
      //       return Navigator(
      //           key: StackedService.nestedNavigationKey(i),
      //           // Optionally track navigation events:
      //           observers: [StackedService.routeObserver],
      //           initialRoute: central_router.Routes.profileView,
      //           onGenerateRoute:
      //               central_router.StackedRouter().onGenerateRoute);
      //     }
      //   )
      // )
    );
  }

  @override
  CentralViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CentralViewModel();
}
