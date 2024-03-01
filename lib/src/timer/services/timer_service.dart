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
  DateTime? _preheatStartTime;
  DateTime? _preheatDoneTime;
  DateTime? _startTime;
  DateTime? _stopTime;
  int _tempCheckInterval = 15;
  final _state = StreamController<RoastTimerState>()
    ..add(RoastTimerState.waiting);
  final _checkTemp = StreamController<Duration>.broadcast();
  final _seconds = StreamController<Duration?>.broadcast();

  void startPreheat() {
    _preheatStartTime = DateTime.now();
    _state.add(RoastTimerState.preheating);
    _fireSeconds(() => _preheatStartTime, () => _preheatDoneTime, (_) {});
  }

  void stopPreheat() {
    _preheatDoneTime = DateTime.now();
    _state.add(RoastTimerState.preheatDone);
  }

  void start(int tempCheckInterval) {
    _startTime = DateTime.now();
    _state.add(RoastTimerState.roasting);
    _tempCheckInterval = tempCheckInterval;
    _fireSeconds(() => _startTime, () => _stopTime, (time) {
      if (time.inSeconds % _tempCheckInterval == 0) {
        FlutterBeep.beep();
        _checkTemp.add(time);
      }
    });
  }

  void reset() {
    _preheatStartTime = null;
    _preheatDoneTime = null;
    _startTime = null;
    _stopTime = null;
    _state.add(RoastTimerState.waiting);
    _seconds.add(null);
  }

  void _fireSeconds(
    DateTime? Function() startTime,
    DateTime? Function() endTime,
    void Function(Duration) observe,
  ) async {
    while (endTime() == null) {
      final now = _elapsed(startTime(), endTime());

      if (now == null) {
        return;
      }

      observe(now);
      _seconds.add(now);

      final millisToNext = 1000 - (now.inMilliseconds % 1000);
      await Future.delayed(Duration(milliseconds: millisToNext));
    }
  }

  void stop() {
    _stopTime = DateTime.now();
    _state.add(RoastTimerState.done);
  }

  Duration? elapsed() => _elapsed(_startTime, _stopTime);
  Duration? elapsedPreheat() => _elapsed(_preheatStartTime, _preheatDoneTime);

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
