// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class TimeZoneI18n {
  TimeZoneI18n();

  static TimeZoneI18n? _current;

  static TimeZoneI18n get current {
    assert(_current != null,
        'No instance of TimeZoneI18n was loaded. Try to initialize the TimeZoneI18n delegate before accessing TimeZoneI18n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<TimeZoneI18n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = TimeZoneI18n();
      TimeZoneI18n._current = instance;

      return instance;
    });
  }

  static TimeZoneI18n of(BuildContext context) {
    final instance = TimeZoneI18n.maybeOf(context);
    assert(instance != null,
        'No instance of TimeZoneI18n present in the widget tree. Did you add TimeZoneI18n.delegate in localizationsDelegates?');
    return instance!;
  }

  static TimeZoneI18n? maybeOf(BuildContext context) {
    return Localizations.of<TimeZoneI18n>(context, TimeZoneI18n);
  }

  /// `Automatically get system time`
  String get autoGetSystemTime {
    return Intl.message(
      'Automatically get system time',
      name: 'autoGetSystemTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select a time zone`
  String get pleaseSelectTimeZone {
    return Intl.message(
      'Please select a time zone',
      name: 'pleaseSelectTimeZone',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `TimeZonePicker`
  String get timeZonePicker {
    return Intl.message(
      'TimeZonePicker',
      name: 'timeZonePicker',
      desc: '',
      args: [],
    );
  }

  /// `SearchTimeZone`
  String get searchTimeZone {
    return Intl.message(
      'SearchTimeZone',
      name: 'searchTimeZone',
      desc: '',
      args: [],
    );
  }

  /// `CurrentDisplayedTime`
  String get currentDisplayedTime {
    return Intl.message(
      'CurrentDisplayedTime',
      name: 'currentDisplayedTime',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<TimeZoneI18n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<TimeZoneI18n> load(Locale locale) => TimeZoneI18n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
