import 'package:chemical_compounds/core/base/screen_builder.dart';
import 'package:chemical_compounds/core/constants/app_strings.dart';
import 'package:chemical_compounds/features/details/presentation/pages/details_page.dart';
import 'package:chemical_compounds/features/home/presentation/pages/home_page.dart';
import 'package:chemical_compounds/routes/app_routes.dart';
import 'package:chemical_compounds/routes/go_router_observer.dart';
import 'package:chemical_compounds/routes/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class _Path {
  static const String details = '/details';
  static const String home = '/home';
}

final GoRouter appRouter = GoRouter(
  navigatorKey: NavigationHelper().parentNavigatorKey,
  initialLocation: _Path.home,
  observers: <NavigatorObserver>[GoRouterObserver()],
  routes: <RouteBase>[
    ScreenBuilder<HomePage>(
      path: _Path.home,
      name: AppRoutes.home,
      screenBuilder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    ScreenBuilder<DetailsPage>(
      path: '${_Path.details}/:${AppStrings.cid}/:${AppStrings.iupacName}',
      name: AppRoutes.details,
      screenBuilder: (BuildContext context, GoRouterState state) {
        final int cid = int.parse(state.uri.pathSegments[1]);
        final String iupacName = state.uri.pathSegments[2];
        return DetailsPage(cid: cid, iupacName: iupacName);
      },
    ),
  ],
);
