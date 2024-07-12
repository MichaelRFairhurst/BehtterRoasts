import 'package:wakelock_plus/wakelock_plus.dart';

class WakelockService {
  final _clients = <String>{};

  void requestOn(String id) {
    _clients.add(id);
    WakelockPlus.enable();
  }

  void requestOff(String id) {
    _clients.remove(id);
    if (_clients.isEmpty) {
      WakelockPlus.disable();
    }
  }
}
