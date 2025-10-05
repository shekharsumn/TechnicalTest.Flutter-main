import 'package:flutter/material.dart';
import 'package:flutter_tech_task/i10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Test helper utilities for widget testing
class TestHelpers {
  TestHelpers._();

  /// Creates a MaterialApp wrapper with localization support for testing widgets
  static Widget createTestApp({required Widget child}) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
          Locale('la', ''),
        ],
      ),
    );
  }
}
