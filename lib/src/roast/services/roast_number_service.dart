import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:collection/collection.dart';

class RoastNumberService {
  String getNewRoastNumber(String? copyOfRoastId, List<Roast> roastsForBean) {
    final nonCopyName = (_rootRoastsCount(roastsForBean) + 1).toString();
    if (copyOfRoastId == null) {
      return nonCopyName;
    }

    final parent = _getRoast(copyOfRoastId, roastsForBean);
    if (parent == null) {
      return nonCopyName;
    }

    final subNumber = _subRoastsCount(parent.id!, roastsForBean) + 1;
    return '${parent.roastNumber}.$subNumber';
  }

  int _rootRoastsCount(List<Roast> roastsForBean) =>
      roastsForBean.where((roast) => roast.copyOfRoastId == null).length;

  int _subRoastsCount(String id, List<Roast> roastsForBean) =>
      roastsForBean.where((roast) => roast.copyOfRoastId == id).length;

  Roast? _getRoast(String id, List<Roast> roastsForBean) =>
      roastsForBean.singleWhereOrNull((roast) => roast.id == id);
}
