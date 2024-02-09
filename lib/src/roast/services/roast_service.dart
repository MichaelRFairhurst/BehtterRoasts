import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoastService {
  Stream<List<Roast>> get roasts => FirebaseFirestore.instance.collection('roasts').snapshots().map((record) {
	return record.docs.map((doc) => Roast.fromJson(doc.data())).toList();
  });

  Future<void> add(Roast roast) {
	return FirebaseFirestore.instance.collection('roasts').add(roast.toJson());
  }
}
