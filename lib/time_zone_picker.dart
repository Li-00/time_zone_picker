import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';

class TimeZonePicker extends StatefulWidget {
  const TimeZonePicker({super.key});

  @override
  _TimeZonePickerState createState() => _TimeZonePickerState();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            title: Text(Intl.message('autoGetSystemTime')),
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
                  hintText: Intl.message('searchTimeZone'),
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
                    '${Intl.message('selected')}: $_selectedTimeZone',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectTimeZoneAndTime(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(Intl.message('selectTime')),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    Intl.message('currentDisplayedTime'),
                    style: const TextStyle(
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

  // 加载时区列表
  Future<void> _loadTimeZones() async {
    try {
      final timeZones = await FlutterTimezone.getAvailableTimezones();
      if (kDebugMode) {
        _logger.info(
            'TimeZonePicker._loadTimeZones: Loaded timezones: ${timeZones.length}');
        _logger.info(
            'TimeZonePicker._loadTimeZones: First few zones: ${timeZones.take(5)}');
      }
      setState(() {
        _timeZones = timeZones;
      });
    } catch (e) {
      _logger.severe('Error loading timezones: $e');
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                Intl.message('errorLoadingTimeZones', args: [e.toString()]))),
      );
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
    final tzDate = DateTime.now().toLocal();
    setState(() {
      _selectedTime = tzDate;
      _selectedTimeZone = timezone;
      _displayedTime =
          '${DateFormat.yMd().add_jm().format(tzDate)} (${Intl.message(timezone!)})';
    });
  }

  // 选择时间的对话框
  void _selectTimeZoneAndTime() async {
    if (kDebugMode) {
      _logger.info("_selectTimeZoneAndTime:$_selectedTimeZone");
    }
    if (_selectedTimeZone == null) {
      // 未选时区
      showToast(context, 'Please select a time zone');
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
        title: Text(
          Intl.message(timezone),
        ),
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

  void showToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0,
        left: MediaQuery.of(context).size.width * 0.2,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );

    // 插入 OverlayEntry
    overlay.insert(overlayEntry);

    // 延时移除 Toast
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
