import 'dart:io';

import 'package:wakelock_plus/wakelock_plus.dart';

class WakelockService {
  final _clients = <String>{};

  void requestOn(String id) {
    if (Platform.isIOS) {
      // TODO: Get working on iOS and re-enable
      return;
    }

    _clients.add(id);
    WakelockPlus.enable();
  }

  void requestOff(String id) {
    if (Platform.isIOS) {
      // TODO: Get working on iOS and re-enable
      return;
    }

    _clients.remove(id);
    if (_clients.isEmpty) {
      WakelockPlus.disable();
    }
  }
}
