import 'package:behmor_roast/src/roast/models/roast.dart';

class RoastNumberService {
  String getNewRoastNumber(String? copyOfRoastId, List<Roast> roastsForBean) {
    if (copyOfRoastId == null) {
      return (_rootRoastsCount(roastsForBean) + 1).toString();
    }

    final parent = _getRoast(copyOfRoastId, roastsForBean);
    final subNumber = _subRoastsCount(parent.id!, roastsForBean) + 1;
    return '${parent.roastNumber}.$subNumber';
  }

  int _rootRoastsCount(List<Roast> roastsForBean) =>
      roastsForBean.where((roast) => roast.copyOfRoastId == null).length;

  int _subRoastsCount(String id, List<Roast> roastsForBean) =>
      roastsForBean.where((roast) => roast.copyOfRoastId == id).length;

  Roast _getRoast(String id, List<Roast> roastsForBean) =>
      roastsForBean.singleWhere((roast) => roast.id == id);
}
