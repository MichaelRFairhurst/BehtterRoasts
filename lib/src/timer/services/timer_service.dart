import 'dart:async';

class TimerService {
  DateTime? _startTime;
  DateTime? _stopTime;
  final _running = StreamController<bool>()..add(false);
  final _checkTemp = StreamController<void>.broadcast();

  void start() {
    _startTime = DateTime.now();
    _running.add(true);
	fireCheckTempIntervals();
  }

  void fireCheckTempIntervals() async {
    while (_stopTime == null) {
      _checkTemp.add(null);
      await Future.delayed(const Duration(seconds: 15));
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
  Stream<void> get checkTemp => _checkTemp.stream;
}
