import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';
import 'package:behmor_roast/src/roast/services/bean_service.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/roast/services/roast_service.dart';
import 'package:behmor_roast/src/roast/services/roast_summary_service.dart';
import 'package:behmor_roast/src/sign_in/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roastProvider = StateProvider<Roast?>((ref) => null);

final roastServiceProvider = Provider<RoastService>((ref) => RoastService());

final roastLogServiceProvider =
    Provider<RoastLogService>((ref) => RoastLogService());

final roastsProvider = StreamProvider<List<Roast>>((ref) {
  final roastService = ref.watch(roastServiceProvider);
  return roastService.roasts;
});

final roastByIdProvider = StreamProvider.family<Roast, String>((ref, roastId) {
  final roastService = ref.watch(roastServiceProvider);
  return roastService.roast(roastId);
});

final roastSummaryProvider = Provider<RoastSummary?>((ref) {
  final roastSummaryService = RoastSummaryService();
  final roast = ref.watch(roastProvider);
  final beans = ref.watch(beansProvider).value ?? [];
  if (roast == null) {
    return null;
  }
  return roastSummaryService.summarize(
      roast, beans.singleWhere((bean) => bean.id == roast.beanId));
});

final roastsForBeanProvider =
    StreamProvider.family<List<Roast>, String>((ref, beanId) {
  final roastService = ref.watch(roastServiceProvider);
  return roastService.roastsForBean(beanId);
});

final beanServiceProvider = Provider<BeanService>((ref) {
  return BeanService(ref.read(authProvider).value!);
});

final beansProvider = StreamProvider<List<Bean>>((ref) {
  final beanService = ref.watch(beanServiceProvider);
  return beanService.beans;
});
