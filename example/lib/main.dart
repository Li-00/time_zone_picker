// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:time_zone_picker/generated/l10n.dart';
import 'package:time_zone_picker/time_zone_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TimeZonePicker',
      locale: Locale('en', ''),
      localizationsDelegates: [
        TimeZoneI18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('zh', ''),
      ],
      home: Material(
        child: TimeZonePicker(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('timeZonePicker')),
      ),
      body: Center(
          child: Column(
        children: [
          Text(Intl.message('autoGetSystemTime')),
          Text(Intl.message('pleaseSelectTimeZone')),
          Text(Intl.message('selectTime')),
          Text(Intl.message('autoGetSystemTime')),
          Text(Intl.message('autoGetSystemTime'))
        ],
      )),
    );
  }
}
