import 'package:flutter/material.dart';
import 'package:time_zone_picker/time_zone_picker.dart';

void main() {
  runApp(MaterialApp(home: TimeZonePickerExample()));
}

class TimeZonePickerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('时区和时间选择器'),
      ),
      body: Center(
        child: TimeZonePicker(),
      ),
    );
  }
}
