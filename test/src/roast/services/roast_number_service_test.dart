import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_config.dart';
import 'package:behmor_roast/src/roast/services/roast_number_service.dart';
import 'package:test/test.dart';

void main() {
  Roast newRoast({
    required String id,
    required String number,
    String? copyOfRoastId,
  }) =>
      Roast(
        id: id,
        beanId: 'beanId',
        copyOfRoastId: copyOfRoastId,
        config: const RoastConfig(
          targetDevelopment: 0.2,
          tempInterval: 15,
          preheatTarget: 190,
          preheatTimeEst: null,
        ),
        roastNumber: number,
        weightIn: 250,
        weightOut: 250,
        roasted: DateTime(2024, 6, 5, 4, 3),
        preheat: null,
        notes: null,
        tempLogs: const [],
        phaseLogs: const [],
        controlLogs: const [],
      );

  final service = RoastNumberService();

  test('get first roast number', () {
    final firstNumber = service.getNewRoastNumber(null, []);

    expect(firstNumber, equals('1'));
  });

  test('get second roast number', () {
    final secondNumber = service.getNewRoastNumber(null, [
      newRoast(
        id: '1',
        number: '1',
      ),
    ]);

    expect(secondNumber, equals('2'));
  });

  test('get roast number for copy of first', () {
    final copyFirstNumber = service.getNewRoastNumber('1', [
      newRoast(
        id: '1',
        number: '1',
      ),
    ]);

    expect(copyFirstNumber, equals('1.1'));
  });

  test('get roast number for second copy of first', () {
    final copyFirstNumber = service.getNewRoastNumber('1', [
      newRoast(
        id: '1',
        number: '1',
      ),
      newRoast(
        id: '2',
        number: '1.1',
        copyOfRoastId: '1',
      ),
    ]);

    expect(copyFirstNumber, equals('1.2'));
  });

  test('get roast number for copy of second', () {
    final copyFirstNumber = service.getNewRoastNumber('2', [
      newRoast(
        id: '1',
        number: '1',
      ),
      newRoast(
        id: '2',
        number: '2',
      ),
    ]);

    expect(copyFirstNumber, equals('2.1'));
  });

  test('get roast number for second copy of second', () {
    final copyFirstNumber = service.getNewRoastNumber('2', [
      newRoast(
        id: '1',
        number: '1',
      ),
      newRoast(
        id: '2',
        number: '2',
      ),
      newRoast(
        id: '3',
        number: '2.1',
        copyOfRoastId: '2',
      ),
    ]);

    expect(copyFirstNumber, equals('2.2'));
  });

  test('get roast number for copy of copy of first', () {
    final copyFirstNumber = service.getNewRoastNumber('2', [
      newRoast(
        id: '1',
        number: '1',
      ),
      newRoast(
        id: '2',
        number: '1.1',
        copyOfRoastId: '1',
      ),
    ]);

    expect(copyFirstNumber, equals('1.1.1'));
  });

  test('get brand new roast number with many roasts', () {
    final copyFirstNumber = service.getNewRoastNumber('3', [
      newRoast(
        id: '1',
        number: '1',
      ),
      newRoast(
        id: '2',
        number: '1.1',
        copyOfRoastId: '1',
      ),
      newRoast(
        id: '3',
        number: '1.2',
        copyOfRoastId: '1',
      ),
      newRoast(
        id: '4',
        number: '1.2.1',
        copyOfRoastId: '3',
      ),
      newRoast(
        id: '5',
        number: '2',
      ),
      newRoast(
        id: '6',
        number: '2.1',
        copyOfRoastId: '5',
      ),
      newRoast(
        id: '7',
        number: '2.2',
        copyOfRoastId: '5',
      ),
    ]);

    expect(copyFirstNumber, equals('1.2.2'));
  });
}
