import 'dart:async';

import 'package:flutter_beep/flutter_beep.dart';

const _smokeSuppressorTime = Duration(seconds: 7 * 60 + 45);

class TimerService {
  DateTime? _startTime;
  DateTime? _stopTime;
  int _tempCheckInterval = 15;
  final _running = StreamController<bool>()..add(false);
  final _checkTemp = StreamController<Duration>.broadcast();
  final _seconds = StreamController<Duration?>.broadcast();

  void start(int tempCheckInterval) {
    _startTime = DateTime.now();
    _running.add(true);
    _tempCheckInterval = tempCheckInterval;
    _fireSeconds();
  }

  void reset() {
    _startTime = null;
    _stopTime = null;
    _running.add(false);
    _seconds.add(null);
  }

  void _fireSeconds() async {
    while (_stopTime == null) {
      final now = elapsed()!;
      _seconds.add(now);

      if (now.inSeconds % _tempCheckInterval == 0) {
        FlutterBeep.beep();
        _checkTemp.add(now);
      }

      final millisToNext = 1000 - (now.inMilliseconds % 1000);
      await Future.delayed(Duration(milliseconds: millisToNext));
    }
  }

  void stop() {
    _stopTime = DateTime.now();
    _running.add(false);
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

  Stream<bool> get running => _running.stream;
  Stream<Duration> get checkTemp => _checkTemp.stream;
  Stream<Duration?> get seconds => _seconds.stream;
  DateTime? get startTime => _startTime;

  Future<void> smokeSuppressTimer(Duration warningTime) async {
    final completeTime = _smokeSuppressorTime - warningTime;

    Duration? now;
    do {
      // Remember, we might not be roasting (yet). This await will always
      // gracefully complete before we've hit the warning time.
      await Future.delayed(completeTime);
      now = elapsed();
    } while (now == null);

    // Now we're roasting, and can await until the exact waring time.
    await Future.delayed((completeTime) - now);

    // Technically, we may have canceled the roast now and need to complete with
    // an error.
    final doubleCheck = elapsed();
    if (doubleCheck == null || doubleCheck < completeTime) {
      throw 'Error: roast canceled before smoke suppress timer could complete.';
    }

    return;
  }
}
