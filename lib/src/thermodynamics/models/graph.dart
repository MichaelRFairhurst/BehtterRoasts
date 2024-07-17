import 'dart:math';

import 'package:behmor_roast/src/thermodynamics/models/constants.dart';
import 'package:behmor_roast/src/thermodynamics/models/conversions.dart';

class ThermodynamicGraph {
  final List<ThermalEdge> edges;

  ThermodynamicGraph(this.edges);
}

class WattageNode implements ThermalSource {
  final double watts;

  WattageNode({
    required this.watts,
  });

  @override
  double getQ(double tempOtherK) => watts;

  @override
  String get name => '$watts watts';
}

abstract class ThermalNode {
  String get name;
}

abstract class ThermalSource extends ThermalNode {
  double getQ(double tempOtherK);
}

abstract class ThermalSink extends ThermalNode {
  double get tempK;
  double get tempF => kToF(tempK);
  void handleQ(double q, double seconds);
}

class Environment extends ThermalSink {
  @override
  double get tempK => roomTempK;

  @override
  String get name => 'environment';

  @override
  void handleQ(double q, double seconds) {
    // noop
  }
}

class Body extends ThermalSink {
  final double emissivity;
  final double mass;
  final double surfaceArea;
  final double specificHeat;
  @override
  final String name;

  Body({
    required this.emissivity,
    required this.mass,
    required this.surfaceArea,
    required this.specificHeat,
	required this.name,
  });

  @override
  double tempK = roomTempK;

  @override
  void handleQ(double q, double seconds) {
    /// Units: (J/s) / (kg * (J/K/kg)) = (J/s) / (J/K) = K/s
    final dt = q / (mass * specificHeat);

    if (dt.isNaN) {
      // throw or something?
    } else {
      // Units: (K/s) * (F / K) * s = F/s
      tempK = (tempK + dt * seconds).clamp(0, 2000);
    }
  }

  Iterable<RadiatingEdge> radiate(Map<ThermalSink, double> map) {
    return map.entries
        .map((e) => RadiatingEdge(from: this, to: e.key, factor: e.value));
  }
}

abstract class ThermalEdge {
  ThermalNode get from;
  ThermalSink get to;
  double getQ();
}

class RadiatingEdge implements ThermalEdge {
  @override
  final Body from;
  @override
  final ThermalSink to;

  final double factor;

  RadiatingEdge({
    required this.from,
    required this.to,
    this.factor = 1.0,
  });

  @override
  double getQ() =>
      // Units: (W / m2*K4) * ratio * m2 * K4 = W = J/s
      factor *
      sigmaSBC *
      from.emissivity *
      from.surfaceArea *
      (pow(from.tempK, 4) - pow(to.tempK, 4));
}

class WattageEdge implements ThermalEdge {
  @override
  final WattageNode from;

  @override
  ThermalSink to;

  double factor;

  WattageEdge({
    required this.from,
    required this.to,
    this.factor = 1.0,
  });

  @override
  double getQ() => from.watts * factor;
}

class ConvectionEdge implements ThermalEdge {
  @override
  final Body from;
  @override
  final ThermalSink to;

  double heatTransferCoefficient;

  ConvectionEdge({
    required this.from,
    required this.to,
    required this.heatTransferCoefficient,
  });

  @override
  double getQ() =>
      // Units: (W / m2*K4) * ratio * m2 * K4 = W = J/s
      heatTransferCoefficient * from.surfaceArea * (from.tempK - to.tempK);
}
