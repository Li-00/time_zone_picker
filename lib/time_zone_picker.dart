import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';

class TimeZonePicker extends StatefulWidget {
  const TimeZonePicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeZonePickerState createState() => _TimeZonePickerState();

  String getPlatformVersion() {
    return '1';
  }
}

class _TimeZonePickerState extends State<TimeZonePicker> {
  bool _isAutoTime = true;
  DateTime? _selectedTime;
  String? _selectedTimeZone;
  String _displayedTime = '';
  List<String> _timeZones = [];

  final Logger _logger = Logger('TimeZonePicker');

  @override
  void initState() {
    super.initState();
    _setSystemTime();
    _loadTimeZones();
  }

  // 加载时区列表
  Future<void> _loadTimeZones() async {
    try {
      final timeZones = await FlutterTimezone.getAvailableTimezones();
      if (kDebugMode) {
        _logger.info('Loaded timezones: ${timeZones.length}');
        _logger.info('First few zones: ${timeZones.take(5)}');
      }
      setState(() {
        _timeZones = timeZones;
      });
    } catch (e) {
      _logger.severe('Error loading timezones: $e');
    }
  }

  // 获取并展示系统时间
  void _setSystemTime() {
    final now = DateTime.now();
    final systemTimeZone = DateTime.now().timeZoneName;
    setState(() {
      _displayedTime =
          '${DateFormat.yMd().add_jm().format(now)} ($systemTimeZone)';
    });
  }

  // 更新用户选择的时间
  Future<void> _updateSelectedTime(DateTime date, String? timezone) async {
    final tzDate =
        DateTime.now().toLocal(); // Use local DateTime instead of TZDateTime
    setState(() {
      _selectedTime = tzDate;
      _selectedTimeZone = timezone;
      _displayedTime =
          '${DateFormat.yMd().add_jm().format(tzDate)} ($timezone)';
    });
  }

  // 选择时间的对话框
  void _selectTimeZoneAndTime() async {
    if (_selectedTimeZone == null) {
      // 如果没有选择时区，显示提示
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先选择时区')),
      );
      return;
    }

    await DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        _updateSelectedTime(date, _selectedTimeZone);
      },
      currentTime: _selectedTime ?? DateTime.now(),
    );
  }

  Iterable<Widget> _getTimeZoneList(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _timeZones.where((timezone) {
      return timezone.toLowerCase().contains(lowercaseQuery);
    }).map((timezone) {
      return ListTile(
        title: Text(timezone),
        onTap: () {
          setState(() {
            _selectedTimeZone = timezone;
            if (_selectedTime != null) {
              _updateSelectedTime(_selectedTime!, timezone);
            }
          });
          Navigator.pop(context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            title: const Text('自动获取系统时间'),
            value: _isAutoTime,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              setState(() {
                _isAutoTime = value;
                if (_isAutoTime) {
                  _setSystemTime();
                }
              });
            },
          ),
          if (!_isAutoTime) ...[
            const SizedBox(height: 16),
            SearchAnchor(
              builder: (context, controller) {
                return SearchBar(
                  controller: controller,
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  hintText: '搜索时区...',
                  trailing: _selectedTimeZone != null
                      ? [
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _selectedTimeZone = null;
                              });
                              controller.clear();
                            },
                          )
                        ]
                      : null,
                );
              },
              suggestionsBuilder: (context, controller) {
                return _getTimeZoneList(controller.text);
              },
            ),
            if (_selectedTimeZone != null) ...[
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '已选择: $_selectedTimeZone',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectTimeZoneAndTime(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('选择时间'),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    '当前显示时间',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _displayedTime,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
