import 'dart:async';

import 'package:behmor_roast/src/roast/models/roast_config.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:behmor_roast/src/timer/services/projection_service.dart';
import 'package:rxdart/rxdart.dart';

import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/instructions/services/instructions_service.dart';
import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';

class RoastManagerService {
  final RoastLogService roastLogService;
  final ProjectionService projectionService;
  final TimerService timerService;
  final TimerService preheatTimerService;

  RoastManagerService({
    required this.roastLogService,
    required this.projectionService,
    required this.timerService,
    required this.preheatTimerService,
  }) {
    timerService.seconds.listen(_updateSeconds);
    copyOfRoastLogs.listen(_updateCopyOfRoastLogs);
    _coreInstructionsCtrl.listen((_) => _updateTemporalInstructions());

    reset();
  }

  final _copyOfRoastCtrl = BehaviorSubject<Roast?>();
  final _timeline = BehaviorSubject<RoastTimeline>();
  final _coreInstructionsCtrl = BehaviorSubject<List<CoreInstruction>?>();
  final _temporalInstructionsCtrl =
      BehaviorSubject<List<TemporalInstruction>?>();
  final _roastConfig = BehaviorSubject<RoastConfig>();

  void setRoastConfig(RoastConfig config) {
    _roastConfig.add(config);
  }

  void reset() {
    _copyOfRoastCtrl.add(null);
    _timeline.add(const RoastTimeline(rawLogs: []));
    timerService.reset();
    preheatTimerService.reset();
  }

  void setCopyRoast(Roast? roast) {
    _copyOfRoastCtrl.add(roast);
  }

  void _updateCopyOfRoastLogs(List<RoastLog>? logs) {
    final timeline = _copyOfRoastCtrl.valueOrNull?.toTimeline();
    if (logs == null || timeline == null) {
      _coreInstructionsCtrl.add(null);
    } else {
      _coreInstructionsCtrl.add(
          InstructionsService().createCoreCopyInstructions(logs, timeline));
    }
  }

  void start(Roast roast) {
    timerService.start(roast.config.tempInterval);
    _timeline.add(_timeline.value.copyWith(startTime: timerService.startTime));
  }

  void startPreheat() {
    _timeline.add(_timeline.value.copyWith(preheatStart: DateTime.now()));
    preheatTimerService.start(null);
  }

  void skipPreheat() {
    _timeline.add(_timeline.value.copyWith(preheatTemp: -1));
  }

  void stopPreheat() {
    _timeline.add(
        _timeline.value.copyWith(preheatEnd: preheatTimerService.elapsed()!));
    preheatTimerService.stop();
  }

  void stopRoast() {
    _timeline.add(_timeline.value.copyWith(done: timerService.elapsed()!));
    timerService.stop();
  }

  void finalizePreheat(int preheatTemp) {
    _timeline.add(_timeline.value.copyWith(preheatTemp: preheatTemp));
  }

  void markDryEnd() {
    final dryEnd = timerService.elapsed()!;
    _timeline.add(_timeline.value.copyWith(dryEnd: dryEnd));
  }

  void markFirstCrack() {
    final firstCrack = timerService.elapsed()!;
    _timeline.add(_timeline.value.copyWith(
      firstCrackStart: _timeline.value.firstCrackStart ?? firstCrack,
      firstCrackEnd: firstCrack,
    ));
  }

  void markSecondCrack() {
    final secondCrack = timerService.elapsed()!;
    _timeline.add(_timeline.value.copyWith(secondCrackStart: secondCrack));
  }

  void pressControl(Control control, TemporalInstruction? instruction) {
    final now = timerService.elapsed() ?? const Duration(seconds: 0);

    if (instruction != null) {
      // This method checks for double presses, in which case it
      // returns a non-null RoastTimeline result which handles the
      // double press case.
      final alreadyPressedTimeline = InstructionsService()
          .checkControlWasLastPressed(
              _timeline.value, control, instruction.core);

      if (alreadyPressedTimeline != null) {
        // Save the new RoastTimeline that has handled the double
        // press case.
        _timeline.add(alreadyPressedTimeline);

        // Mark the instruction completed.
        _coreInstructionsCtrl.add(InstructionsService()
            .skipInstruction(_coreInstructionsCtrl.value!, instruction));

        // Nothing else to do. Do not add a second control log for this.
        return;
      }
    }

    final Duration? timeDiff;
    if (instruction != null) {
      timeDiff = instruction.time;

      // Mark the instruction completed.
      _coreInstructionsCtrl.add(InstructionsService()
          .skipInstruction(_coreInstructionsCtrl.value!, instruction));
    } else {
      final instructions = _temporalInstructionsCtrl.valueOrNull;

      // If we're pressing P5 in the control panel, and the
      // instructions say we're 5 seconds late to press P5, then
      // retrieve and complete that corresponding instruction.
      final isFulfillingInstruction = InstructionsService()
          .checkControlFulfillsInstruction(now, control, instructions);

      // Use the time diff for this instruction, if it exists.
      timeDiff = isFulfillingInstruction?.time;

      if (isFulfillingInstruction != null) {
        // Mark instruction completed.
        _coreInstructionsCtrl.add(InstructionsService().skipInstruction(
            _coreInstructionsCtrl.value!, isFulfillingInstruction));
      }
    }

    final newLog = ControlLog(
      time: now,
      control: control,
      instructionTimeDiff: timeDiff,
    );

    _timeline.add(_timeline.value.addLog(newLog));
  }

  void addTemp(Duration time, int temp) {
    _timeline.add(_timeline.value.addLog(TempLog(time: time, temp: temp)));
  }

  void editTemp(RoastLog log, int newTemp) {
    if (log.phase == RoastPhase.preheat) {
      _timeline.add(_timeline.value.copyWith(preheatTemp: newTemp));
    } else {
      _timeline.add(_timeline.value.updateTemp(log.time, newTemp));
    }
  }

  void completeInstruction(TemporalInstruction instruction) {
    _coreInstructionsCtrl.add(InstructionsService()
        .skipInstruction(_coreInstructionsCtrl.value!, instruction));
  }

  void _updateSeconds(Duration? seconds) {
    _updateTemporalInstructions();
  }

  void _updateTemporalInstructions() {
    final seconds = timerService.elapsed();
    final instructions = _coreInstructionsCtrl.valueOrNull;
    if (instructions != null && seconds != null) {
      _temporalInstructionsCtrl.add(InstructionsService()
          .createTemporalInstructions(seconds, instructions));
    } else {
      _temporalInstructionsCtrl.add(null);
    }
  }

  Stream<List<RoastLog>> get roastLogs => CombineLatestStream.combine2(
        _timeline,
        copyOfRoast,
        (tl, copy) => roastLogService.aggregate(tl, copy: copy?.toTimeline()),
      );

  Stream<RoastTimeline> get roastTimeline => _timeline.stream;

  Stream<Projection> get projection {
    return CombineLatestStream.combine4(
        timerService.seconds, _roastConfig, roastLogs, copyOfRoast,
        (seconds, config, logs, copyOfRoast) {
      return projectionService.createProjections(
        roastConfig: config,
        roastLogs: logs,
        elapsed: seconds,
        copyOfRoast: copyOfRoast?.toTimeline(),
      );
    });
  }

  Stream<List<TemporalInstruction>?> get instructions =>
      _temporalInstructionsCtrl.stream;

  Stream<Roast?> get copyOfRoast => _copyOfRoastCtrl.stream;

  Stream<List<RoastLog>?> get copyOfRoastLogs => _copyOfRoastCtrl.map((copy) {
        final copyTimeline = copy?.toTimeline();
        if (copyTimeline == null) {
          return null;
        }

        return roastLogService.aggregate(copyTimeline);
      });
}
