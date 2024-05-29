import 'dart:async';

import 'package:behmor_roast/src/timer/services/wakelock_service.dart';
import 'package:flutter_beep/flutter_beep.dart';

class TimerService {
  TimerService({
	required this.id,
	required this.wakelockService,
  });

  final String id;
  final WakelockService wakelockService;

  DateTime? _startTime;
  DateTime? _stopTime;
  int? _tempCheckInterval;
  final _checkTemp = StreamController<Duration>();
  final _seconds = StreamController<Duration?>();

  void start(int? tempCheckInterval) {
    _startTime = DateTime.now();
    _tempCheckInterval = tempCheckInterval;
    _fireSeconds();
	wakelockService.requestOn(id);
  }

  void reset() {
    _startTime = null;
    _stopTime = null;
    _seconds.add(null);
	wakelockService.requestOff(id);
  }

  void _fireSeconds() async {
    while (_stopTime == null) {
      final unrounded = elapsed();

      if (unrounded == null) {
        return;
      }

      final now = _round(unrounded);

      if (_tempCheckInterval != null &&
          now.inSeconds % _tempCheckInterval! == 0) {
        FlutterBeep.beep();
        _checkTemp.add(now);
      }
      _seconds.add(now);

      final millisToNext = 1000 - (unrounded.inMilliseconds % 1000);
      await Future.delayed(Duration(milliseconds: millisToNext));
    }
  }

  Duration _round(Duration duration) => Duration(seconds: duration.inSeconds);

  void stop() {
    _stopTime = DateTime.now();
	wakelockService.requestOff(id);
  }

  Duration? elapsed() {
    if (_startTime == null) {
      return null;
    }

    if (_stopTime != null) {
      return _stopTime!.difference(_startTime!);
    }

    return DateTime.now().difference(_startTime!);
  }

  Stream<Duration> get checkTemp => _checkTemp.stream;
  Stream<Duration?> get seconds => _seconds.stream;
  DateTime? get startTime => _startTime;
}
