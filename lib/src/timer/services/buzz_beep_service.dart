import 'dart:async';

import 'package:flutter_beep/flutter_beep.dart';
import 'package:vibration/vibration.dart';

enum BuzzBeepState {
  buzz,
  buzzBeep,
  silent,
}

enum BuzzBeepKind {
  tempCheck,
  preheatEarlyWarning,
  preheatExpired,
  warning,
  alert,
}

const _twoQuickVibrations = [150, 100, 150];
const _mediumLengthVibration = [800];
const _longLengthVibration = [1200];

class BuzzBeepService {
  var _state = BuzzBeepState.buzzBeep;

  final _stateCtrl = StreamController<BuzzBeepState>.broadcast();

  Stream<BuzzBeepState> get stateStream => _stateCtrl.stream;
  BuzzBeepState get state => _state;
  set state(BuzzBeepState state) {
    _stateCtrl.add(state);
    _state = state;
  }

  void trigger(BuzzBeepKind kind) {
    if (_state == BuzzBeepState.silent) {
      return;
    }

    switch (kind) {
      case BuzzBeepKind.tempCheck:
      case BuzzBeepKind.preheatEarlyWarning:
        _buzzBeep(severe: false, vibration: _twoQuickVibrations);
        break;

      case BuzzBeepKind.alert:
        _buzzBeep(severe: false, vibration: _mediumLengthVibration);
        break;
      case BuzzBeepKind.preheatExpired:
      case BuzzBeepKind.warning:
        _buzzBeep(severe: false, vibration: _longLengthVibration);
    }
  }

  void _buzzBeep({required bool severe, required List<int>? vibration}) {
    _beep(severe: severe);
    if (vibration != null) {
      _vibrate(vibration);
    }
  }

  void _beep({required bool severe}) {
    if (_state != BuzzBeepState.buzzBeep) {
      return;
    }

    FlutterBeep.beep(!severe);
  }

  void _vibrate(List<int> pattern) {
    if (_state != BuzzBeepState.buzz && _state != BuzzBeepState.buzzBeep) {
      return;
    }

    Vibration.vibrate(
      pattern: pattern,
      intensities: [
        for (int i = 0; i < pattern.length; ++i) i % 2 == 0 ? 255 : 0,
      ],
    );
  }
}
