import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/app_theme.dart';
import 'src/navigation/root_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppUsers());
}

class AppUsers extends StatelessWidget {
  const AppUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,

      // ✅ عربي فقط
      supportedLocales: const [Locale('ar')],
      locale: const Locale('ar'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home: const RootScaffold(),
    );
  }
}