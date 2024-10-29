# time_zone_picker

A Flutter plugin for selecting time zones and displaying the current time based on the selected time zone.
一个用于选择时区并根据所选时区显示当前时间的 Flutter 插件。

## Features

- Automatically fetches and displays the system time.
- Allows users to select a time zone from a searchable list.
- Displays the currently selected time and time zone.
- Provides a user-friendly interface with a date and time picker.

- 自动获取并显示系统时间。
- 允许用户从可搜索的列表中选择时区。
- 显示当前选择的时间和时区。
- 提供带有日期和时间选择器的用户友好界面。

Flutter 3.24.4 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 603104015d (5 days ago) • 2024-10-24 08:01:25 -0700
Engine • revision db49896cf2
Tools • Dart 3.5.4 • DevTools 2.37.3

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

该项目是 Flutter 的起始点
[插件包](https://flutter.dev/to/develop-plugins)，
一个包含 Android 和/或 iOS 平台特定实现代码的专用包。

### Installation

Add the following dependency to your `pubspec.yaml` file:

将以下依赖项添加到您的 `pubspec.yaml` 文件中：

```yaml
dependencies:
  flutter_datetime_picker_plus: ^2.2.0
  intl: ^0.19.0
  flutter_timezone: ^3.0.1
```

### Usage

To use the `TimeZonePicker` widget, simply include it in your widget tree:

要使用 `TimeZonePicker` 小部件，只需将其包含在您的小部件树中：

```dart
import 'package:time_zone_picker/time_zone_picker.dart';

// Inside your widget build method
@override
Widget build(BuildContext context) {
  return TimeZonePicker();
}
```

