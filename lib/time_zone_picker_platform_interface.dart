import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'time_zone_picker_method_channel.dart';

abstract class TimeZonePickerPlatform extends PlatformInterface {
  /// Constructs a TimeZonePickerPlatform.
  TimeZonePickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static TimeZonePickerPlatform _instance = MethodChannelTimeZonePicker();

  /// The default instance of [TimeZonePickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelTimeZonePicker].
  static TimeZonePickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TimeZonePickerPlatform] when
  /// they register themselves.
  static set instance(TimeZonePickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
