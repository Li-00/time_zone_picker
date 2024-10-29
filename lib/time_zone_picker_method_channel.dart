import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'time_zone_picker_platform_interface.dart';

/// An implementation of [TimeZonePickerPlatform] that uses method channels.
class MethodChannelTimeZonePicker extends TimeZonePickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('time_zone_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
