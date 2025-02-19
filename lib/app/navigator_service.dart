import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utility_module/logger/logger.dart';
import 'package:zinc/app/app_prefs.dart';
import 'package:zinc/app/router.dart';
import 'package:zinc/app/router_extensions.dart';
import 'package:zinc/lob/airwallex/router.dart';
import 'package:zinc/lob/remittance/router.dart';

abstract class NavigatorService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: NavigatorService.navigatorKey,
    routes: [
      ...CommonRouter.routes,
      ...AWRouter.routes,
      ...RemittanceRouter.routes,
    ],
    errorBuilder: (context, state) {
      return NoRouteScreen(state.uri);
    },
    redirect: (context, state) async {
      logMessage("Step------------------------> 7 ${state.uri.toString()}");
      logMessage("state.path: ${state.matchedLocation}");
      String? route = await _redirect(context, state);
      return route;
    },
  );
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  bool isLogged = await checkIsAuthenticated() ?? false;
  if (defaultRoutes.isPathOf(state.matchedLocation) || isLogged) {
    return null;
  } else {
    return "/";
  }
}

Future<bool?> checkIsAuthenticated() async {
  return await AppPreferences.getInstance.getBool(PrefKeys.isLoggedIn);
}
