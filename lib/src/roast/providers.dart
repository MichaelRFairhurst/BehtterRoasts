import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/services/roast_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roastProvider = StateProvider<Roast?>((ref) => null);
final roastServiceProvider = Provider<RoastService>((ref) => RoastService());
final roastsProvider = StreamProvider<List<Roast>>((ref) {
  final roastService = ref.watch(roastServiceProvider);
  return roastService.roasts;
});

