import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const _beandb = 'beans';

class BeanService {
  final User _auth;

  final _africaRegex = RegExp(
    <String>{
      'africa',
      'angola',
      'burundi',
      'benin',
      'camaroon',
      'congo',
      'ethiopia',
      'kenya',
      'madagascar',
      'malawi',
      'niger',
      'rwanda',
      'senegal',
      'tanzania',
      'uganda',
      'yemen',
      'zimbabwe',
    }.map((s) => '($s)').join('|'),
    caseSensitive: false,
  );

  final _asiaRegex = RegExp(
    <String>{
      'asia',
      'cambodia',
      'china',
      'india',
      'laos',
      'myanmar',
      'nepal',
      'sri lanka',
      'srilanka',
      'thailand',
      'vietnam',
    }.map((s) => '($s)').join('|'),
    caseSensitive: false,
  );

  final _indonesiaRegex = RegExp(
    <String>{
      'indonesia',
      'aceh',
      'bali',
      'bengkulu',
      'celebes',
      'flores',
      'guinea',
      'jambi',
      'java',
      'lampung',
      'mandheling',
      'sulawesi',
      'sumatra',
      'timor',
      'toraja',
    }.map((s) => '($s)').join('|'),
    caseSensitive: false,
  );

  final _southAmericaRegex = RegExp(
    <String>{
      'south america',
      'bolivia',
      'brazil',
      'colombia',
      'ecuador',
      'guyana',
      'peru',
      'paraguay',
      'uruguay',
      'venezuela',
    }.map((s) => '($s)').join('|'),
    caseSensitive: false,
  );

  final _centralAmericaRegex = RegExp(
    <String>{
      'central',
      'costa rica',
      'guatemala',
      'honduras',
      'nicaragua',
      'mexico',
      'panama',
      'salvador',
    }.map((s) => '($s)').join('|'),
    caseSensitive: false,
  );

  BeanService(this._auth);

  Stream<List<Bean>> get beans => FirebaseFirestore.instance
          .collection(_beandb)
          .where('ownerId', isEqualTo: _auth.uid)
          .snapshots()
          .map((record) {
        return record.docs
            .map((doc) => Bean.fromJson(doc.data()).copyWith(id: doc.id))
            .toList();
      });

  Future<void> update(Bean bean) {
    return FirebaseFirestore.instance
        .collection(_beandb)
        .doc(bean.id!)
        .update(bean.toJson());
  }

  Future<Bean> add(Bean bean) async {
    final result =
        await FirebaseFirestore.instance.collection(_beandb).add(bean.toJson());
    return bean.copyWith(id: result.id);
  }

  Continent continentOf(Bean bean) {
    if (_africaRegex.hasMatch(bean.name)) {
      return Continent.africa;
    } else if (_asiaRegex.hasMatch(bean.name)) {
      return Continent.asia;
    } else if (_indonesiaRegex.hasMatch(bean.name)) {
      return Continent.indonesia;
    } else if (_southAmericaRegex.hasMatch(bean.name)) {
      return Continent.southAmerica;
    } else if (_centralAmericaRegex.hasMatch(bean.name)) {
      return Continent.centralAmerica;
    } else {
      return Continent.other;
    }
  }
}
