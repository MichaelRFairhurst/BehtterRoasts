import 'package:behmor_roast/src/thermodynamics/models/graph.dart';

class ThermodynamicsService {
  void simulateGraph(ThermodynamicGraph graph, Duration duration,
      {int stepSizeMs = 50}) {
    var time = Duration.zero;
    final stepSize = Duration(milliseconds: stepSizeMs);
    final end = duration - stepSize;
    for (; time <= end; time += stepSize) {
      stepGraph(graph, stepSizeMs / 1000);
    }

    final remainder = duration - time;
    final ms = remainder.inMilliseconds;
    if (ms != 0) {
      stepGraph(graph, ms / 1000);
    }
  }

  Duration simulateUntil(
      ThermodynamicGraph graph, bool Function(Duration) condition,
      {int stepSizeMs = 50}) {
    final stepSize = Duration(milliseconds: stepSizeMs);

    var time = Duration.zero;
    for (; !condition(time); time += stepSize) {
      stepGraph(graph, stepSizeMs / 1000);
    }

    return time;
  }

  void stepGraph(ThermodynamicGraph graph, double seconds) {
    final qs = <ThermalSink, double>{};

    for (final edge in graph.edges) {
      final node = edge.from;
      final target = edge.to;

      final q = edge.getQ();
      if (node is ThermalSink) {
        qs.update(node, (v) => v - q, ifAbsent: () => -q);
      }
      qs.update(target, (v) => v + q, ifAbsent: () => q);
    }

    for (final entry in qs.entries) {
      entry.key.handleQ(entry.value, seconds);
    }
  }
}
