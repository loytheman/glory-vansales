import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:m360_app_corpsec/app/app.router.dart' as root;
import 'package:m360_app_central/app/app.router.dart' as central;

class CombinedRouter extends RouterBase {
  final _rootRouter    = root.StackedRouter();
  final _centralRouter = central.StackedRouter();

  @override
  List<RouteDef> get routes => [
    ..._rootRouter.routes,
    ..._centralRouter.routes,
  ];

  @override
  Map<Type, StackedRouteFactory> get pagesMap => {
    ..._rootRouter.pagesMap,
    ..._centralRouter.pagesMap,
  };

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings, [String? origin]) {
    // 1) Ask the root router if it knows this route name…
    // print(settings);
    final rootRoute = _rootRouter.onGenerateRoute(settings);
  
    // 2) If rootRouter returned a non-null Route, *that* is your answer:
    if (rootRoute != null) {
      return rootRoute;
    }
    // 3) Otherwise (rootRouter returned null → meaning “I don’t know this name”),
    //    fall back and let the central module router try:
    return _centralRouter.onGenerateRoute(settings);
  }
}
