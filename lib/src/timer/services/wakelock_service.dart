// TODO: Get working on iOS and re-enable
//import 'package:wakelock_plus/wakelock_plus.dart';

class WakelockService {
  final _clients = <String>{};

  void requestOn(String id) {
    // TODO: Get working on iOS and re-enable
    //_clients.add(id);
    //WakelockPlus.enable();
  }

  void requestOff(String id) {
    // TODO: Get working on iOS and re-enable
    //_clients.remove(id);
    //if (_clients.isEmpty) {
    //  WakelockPlus.disable();
    //}
  }
}
