import 'dart:async';

import 'package:flutter_beep/flutter_beep.dart';

const _smokeSuppressorTime = Duration(seconds: 7 * 60 + 45);

enum RoastTimerState {
  waiting,
  preheating,
  preheatDone,
  roasting,
  done,
}

class TimerService {
  DateTime? _startTime;
  DateTime? _roastTime;
  DateTime? _stopTime;
  int _tempCheckInterval = 15;
  final _state = StreamController<RoastTimerState>()
    ..add(RoastTimerState.waiting);
  final _checkTemp = StreamController<Duration>.broadcast();
  final _secondsRoast = StreamController<Duration?>.broadcast();
  final _secondsTotal = StreamController<Duration?>.broadcast();

  void startPreheat() {
    _startTime = DateTime.now();
    _state.add(RoastTimerState.preheating);
    _fireSeconds(() => _startTime, () => _stopTime, (_) {}, _secondsTotal);
  }

  void stopPreheat() {
    _state.add(RoastTimerState.preheatDone);
  }

  void start(int tempCheckInterval) {
    _roastTime = DateTime.now();
    _startTime ??= _roastTime;
    _state.add(RoastTimerState.roasting);
    _tempCheckInterval = tempCheckInterval;
    _fireSeconds(() => _roastTime, () => _stopTime, (time) {
      if (time.inSeconds % _tempCheckInterval == 0) {
        FlutterBeep.beep();
        _checkTemp.add(time);
      }
    }, _secondsRoast);
  }

  void reset() {
    _startTime = null;
    _roastTime = null;
    _stopTime = null;
    _state.add(RoastTimerState.waiting);
    _secondsTotal.add(null);
    _secondsRoast.add(null);
  }

  void _fireSeconds(
    DateTime? Function() startTime,
    DateTime? Function() endTime,
    void Function(Duration) observe,
    StreamController<Duration?> streamCtrl,
  ) async {
    while (endTime() == null) {
      final now = _elapsed(startTime(), endTime());

      if (now == null) {
        return;
      }

      observe(now);
      streamCtrl.add(now);

      final millisToNext = 1000 - (now.inMilliseconds % 1000);
      await Future.delayed(Duration(milliseconds: millisToNext));
    }
  }

  void stop() {
    _stopTime = DateTime.now();
    _state.add(RoastTimerState.done);
  }

  Duration? elapsed() => _elapsed(_startTime, _stopTime);
  Duration? elapsedRoast() => _elapsed(_roastTime, _stopTime);

  Duration? _elapsed(DateTime? start, DateTime? stop) {
    if (start == null) {
      return null;
    }

    if (stop != null) {
      return stop.difference(start);
    }

    return DateTime.now().difference(start);
  }

  Stream<RoastTimerState> get state => _state.stream;
  Stream<Duration> get checkTemp => _checkTemp.stream;
  Stream<Duration?> get seconds => _secondsTotal.stream;
  Stream<Duration?> get secondsTotal => _secondsTotal.stream;
  Stream<Duration?> get secondsRoast => _secondsRoast.stream;
  DateTime? get startTime => _startTime;
  DateTime? get roastTime => _roastTime;

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
