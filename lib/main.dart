import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/providers/providers.dart';
import 'package:my_garden/screens/screens.dart';
import 'package:my_garden/services/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final preferences = await SharedPreferences.getInstance();
    final preferencesService = PreferencesService(preferences: preferences);

    final sqlService = SqlService();
    await sqlService.init();

    await NotificationService().init();

    runApp(ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MyApp(
          sqlService: sqlService,
          preferencesService: preferencesService,
        );
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
  const MyApp({
    super.key,
    required this.sqlService,
    required this.preferencesService,
  });

  final SqlService sqlService;
  final PreferencesService preferencesService;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/welcome',
      routes: [
        GoRoute(
          path: '/welcome',
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: WelcomeScreen(),
            );
          },
        ),
        ShellRoute(
          pageBuilder: (context, state, child) {
            final hasBottomBar = (!state.fullPath!.contains('privacy') &&
                !state.fullPath!.contains('notification') &&
                !state.fullPath!.contains('tasks') &&
                !state.fullPath!.contains('actions'));
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
        Provider.value(value: widget.preferencesService),
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
          create: (context) => PreferencesProvider(
            service: widget.preferencesService,
          )..init(),
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
