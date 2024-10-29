import 'package:flutter_test/flutter_test.dart';
import 'package:time_zone_picker/time_zone_picker.dart';
import 'package:time_zone_picker/time_zone_picker_platform_interface.dart';
import 'package:time_zone_picker/time_zone_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTimeZonePickerPlatform
    with MockPlatformInterfaceMixin
    implements TimeZonePickerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TimeZonePickerPlatform initialPlatform = TimeZonePickerPlatform.instance;

  test('$MethodChannelTimeZonePicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTimeZonePicker>());
  });

  test('getPlatformVersion', () async {
    TimeZonePicker timeZonePickerPlugin = TimeZonePicker();
    MockTimeZonePickerPlatform fakePlatform = MockTimeZonePickerPlatform();
    TimeZonePickerPlatform.instance = fakePlatform;

    expect(await timeZonePickerPlugin.getPlatformVersion(), '42');
  });
}
