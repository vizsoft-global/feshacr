import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';
import 'flutter_flow/revenue_cat_util.dart' as revenue_cat;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  // True fullscreen across the whole app — hide the system status bar AND the
  // Android navigation bar. `immersiveSticky` lets the user briefly reveal them
  // with an edge swipe and then auto-hides them again. Web builds are no-ops.
  if (!kIsWeb) {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: const [],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  final environmentValues = FFDevEnvironmentValues();
  await environmentValues.initialize();

  await initFirebase();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  await revenue_cat.initialize(
    "appl_TlpiHIspgtxThmFUUqrZXUkSECY",
    "",
    debugLogEnabled: true,
    loadDataAfterLaunch: true,
  );

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Locale? _locale;

  ThemeMode _themeMode = ThemeMode.system;
  double _textScaleFactor = 1.0;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.path;
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((user) {
    revenue_cat.login(user?.uid);
  });
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = feshahFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: isWeb ? 0 : 2000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Android (and to a lesser extent iOS) can restore the system bars when
    // the app returns from background, after a permission dialog, or after
    // the soft keyboard hides. Re-arm immersive mode so fullscreen sticks.
    if (state == AppLifecycleState.resumed && !isWeb) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
        overlays: const [],
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
    // Keep FFAppState in sync with MaterialApp locale. The home language
    // selector only called setLocale; UserStatusChecker / AppLanguageWidget
    // re-apply FFAppState().appLang and would otherwise force Arabic again.
    final supported = FFLocalizations.languages();
    final String? persistedCode = supported.contains(language)
        ? language
        : supported.contains(language.split('_').first)
            ? language.split('_').first
            : null;
    if (persistedCode != null && FFAppState().appLang != persistedCode) {
      FFAppState().appLang = persistedCode;
    }
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  void setTextScaleFactor(double updatedFactor) {
    if (updatedFactor < FlutterFlowTheme.minTextScaleFactor ||
        updatedFactor > FlutterFlowTheme.maxTextScaleFactor) {
      return;
    }
    safeSetState(() {
      _textScaleFactor = updatedFactor;
    });
  }

  void incrementTextScaleFactor(double incrementValue) {
    final updatedFactor = _textScaleFactor + incrementValue;
    if (updatedFactor < FlutterFlowTheme.minTextScaleFactor ||
        updatedFactor > FlutterFlowTheme.maxTextScaleFactor) {
      return;
    }
    safeSetState(() {
      _textScaleFactor = updatedFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Feshah',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
      builder: (_, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler:
              _textScaleFactor == FlutterFlowTheme.defaultTextScaleFactor
                  ? MediaQuery.of(context).textScaler.clamp(
                        minScaleFactor: FlutterFlowTheme.minTextScaleFactor,
                        maxScaleFactor: FlutterFlowTheme.maxTextScaleFactor,
                      )
                  : TextScaler.linear(_textScaleFactor).clamp(
                      minScaleFactor: FlutterFlowTheme.minTextScaleFactor,
                      maxScaleFactor: FlutterFlowTheme.maxTextScaleFactor,
                    ),
        ),
        child: child!,
      ),
    );
  }
}
