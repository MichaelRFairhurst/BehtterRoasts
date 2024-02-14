import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const _beandb = 'beans';

class BeanService {
  Stream<List<Bean>> get beans => FirebaseFirestore.instance.collection(_beandb).snapshots().map((record) {
	return record.docs.map((doc) => Bean.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  });

  Future<Bean> add(Bean bean) async {
	final result = await FirebaseFirestore.instance.collection(_beandb).add(bean.toJson());
	return bean.copyWith(id: result.id);
  }
}
