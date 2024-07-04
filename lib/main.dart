import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/providers/plants_provider.dart';
import 'package:my_garden/screens/screens.dart';
import 'package:my_garden/services/services.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final sqlService = SqlService();
    await sqlService.init();

    runApp(ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MyApp(sqlService: sqlService);
      },
    ));
  }, (error, stack) {
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stack);
  });
}

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool opaque = true,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration.zero,
    opaque: opaque,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.sqlService});

  final SqlService sqlService;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      routes: [
        ShellRoute(
          pageBuilder: (context, state, child) {
            final hasBottomBar = (!state.fullPath!.contains('privacy') &&
                !state.fullPath!.contains('notification'));
            return buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: NavigationScreen(
                path: state.fullPath!,
                hasBottomBar: hasBottomBar,
                child: child,
              ),
            );
          },
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const PlantsScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'tasks',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const TasksScreen(),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/calendar',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const CalendarScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'actions',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const ActionsScreen(),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const SettingsScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'privacy',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const PrivacyPolicyScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'notification',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const NotificationScreen(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => PlantActionsService(
            widget.sqlService.database,
          ),
        ),
        Provider(
          create: (context) => PlantsService(
            widget.sqlService.database,
          ),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => PlantsProvider(
            plantsService: Provider.of(context, listen: false),
            actionsService: Provider.of(context, listen: false),
            router: _router,
          )..init(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
