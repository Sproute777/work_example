import 'package:flutter/material.dart';
import '/presentation/screens/auth/welcome_screen.dart';
// import '/presentation/screens/home/detail_screen.dart';
import '/presentation/screens/home/home_screen.dart';
import '/presentation/screens/main_screen.dart';
import '/presentation/screens/registration/registration_employer_screen.dart';
import '/presentation/screens/registration/registration_model_screen.dart';
import '/router/router_cubit.dart';
import '/router/router_state.dart';

import '../presentation/screens/splash_screen.dart';

class RootRouterDelegate extends RouterDelegate<RouterState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final RouterCubit _routerCubit;

  RootRouterDelegate(
      GlobalKey<NavigatorState> navigatorKey, RouterCubit routerCubit)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: List.from([
          _materialPage(valueKey: "mainScreen", child: const SplashScreen()),
          ..._extraPages,
        ]),
        onPopPage: _onPopPageParser,
      );

  bool _onPopPageParser(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;
  }

  @override
  Future<bool> popRoute() async {
    if (_extraPages.isNotEmpty) {
      _routerCubit.popExtra();
      return true;
    }
    return await _confirmAppExit();
  }

  List<Page> get _extraPages {
    String? extraPageContent;
    if (_routerCubit.state is LoginPageState) {
      extraPageContent =
          (_routerCubit.state as LoginPageState).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "page-1-extra",
            child: const HomeScreen(),
          ),
      ];
    }
    if (_routerCubit.state is MainPageState) {
      extraPageContent = (_routerCubit.state as MainPageState).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "type",
            child: const MainScreen(
              tabName: 'home',
            ),
          ),
      ];
    }
    if (_routerCubit.state is WelcomePageState) {
      extraPageContent =
          (_routerCubit.state as WelcomePageState).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "type",
            child: WelcomeScreen(text: extraPageContent!),
          ),
      ];
    }
    if (_routerCubit.state is RegistrationPageState) {
      extraPageContent =
          (_routerCubit.state as RegistrationPageState).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "page-1-extra",
            child: const RegistrationEmployerScreen(),
          ),
      ];
    }
    if (_routerCubit.state is RegistrationModelPageState) {
      extraPageContent =
          (_routerCubit.state as RegistrationModelPageState).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "page-1-extra",
            child: const RegistrationModelScreen(),
          ),
      ];
    }
    return [];
  }

  Future<bool> _confirmAppExit() async =>
      await showDialog<bool>(
          context: navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Are you sure you want to exit the app?"),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                TextButton(
                  child: const Text("Confirm"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            );
          }) ??
      true;

  Page _materialPage({
    required String valueKey,
    required Widget child,
  }) =>
      MaterialPage(
        key: ValueKey<String>(valueKey),
        child: child,
      );

//It's not needed for bloc/cubit
  @override
  void addListener(VoidCallback listener) {}

//It's not needed for bloc/cubit
  @override
  void removeListener(VoidCallback listener) {}

//It's not needed for now
  @override
  Future<void> setNewRoutePath(RouterState configuration) async {}
}
