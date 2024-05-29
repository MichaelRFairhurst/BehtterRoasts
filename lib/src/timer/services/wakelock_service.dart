import 'package:wakelock/wakelock.dart';

class WakelockService {
  final _clients = <String>{};

  void requestOn(String id) {
	_clients.add(id);
    Wakelock.enable();
  }

  void requestOff(String id) {
	_clients.remove(id);
    if (_clients.isEmpty) {
      Wakelock.disable();
    }
  }
}
