import 'package:go_router/go_router.dart';
import 'package:khokha_entry/src/routing/app_routes.dart';
import 'package:khokha_entry/src/screens/khokha_entry_form.dart';
import 'package:khokha_entry/src/screens/khokha_home.dart';

final goRouterConfig = GoRouter(routes: [
  GoRoute(
      path: '/',
      name: AppRoutes.homeScreen.name,
      builder: (context, state) => KhokhaHome(),
      routes: [
        GoRoute(
          path: 'entryFormScreen',
          name: AppRoutes.entryFormScreen.name,
          builder: (context, state) => KhokhaEntryForm(),
        )
      ])
]);
