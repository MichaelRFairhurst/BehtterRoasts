import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/services/bean_service.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/roast/services/roast_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roastProvider = StateProvider<Roast?>((ref) => null);

final roastServiceProvider = Provider<RoastService>((ref) => RoastService());

final roastLogServiceProvider = Provider<RoastLogService>((ref) => RoastLogService());

final roastsProvider = StreamProvider<List<Roast>>((ref) {
  final roastService = ref.watch(roastServiceProvider);
  return roastService.roasts;
});

final beanServiceProvider = Provider<BeanService>((ref) => BeanService());

final beansProvider = StreamProvider<List<Bean>>((ref) {
  final beanService = ref.watch(beanServiceProvider);
  return beanService.beans;
});

