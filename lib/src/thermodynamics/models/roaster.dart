import 'package:behmor_roast/src/thermodynamics/models/graph.dart';
import 'package:behmor_roast/src/thermodynamics/models/materials.dart';
import 'package:behmor_roast/src/thermodynamics/models/constants.dart';

// This is a guess, based on 18-gauge steel. Unit: m.
const _enclosureThickness = 1.65e-3;
const _enclosureSA = 0.269;
const _quartzEfficiency = 0.92;

class RoasterThermals {
  final Body quartzElement;
  final Body enclosure;
  final Body coffee;
  final WattageEdge powerInput;
  final ThermodynamicGraph roastingGraph;
  final ThermodynamicGraph roastingWithFanGraph;
  final ThermodynamicGraph preheatingGraph;
  final ThermodynamicGraph openDoorGraph;

  RoasterThermals._({
    required this.quartzElement,
    required this.enclosure,
    required this.coffee,
    required this.powerInput,
    required this.roastingGraph,
    required this.roastingWithFanGraph,
    required this.preheatingGraph,
    required this.openDoorGraph,
  });

  factory RoasterThermals.b1600(double roastWeight) {
    final quartzElement = Body(
      name: 'quartz',
      emissivity: emissivityQuartz,
      surfaceArea: 0.029 * 0.9,
      mass: 1.63e-5 * densityQuartz * 0.95,
      specificHeat: specificHeatQuartz,
    );

    final enclosure = Body(
      name: 'enclosure',
      emissivity: emissivityOxidizedSteel,
      surfaceArea: _enclosureSA * 0.70,
      mass: _enclosureSA * _enclosureThickness * densitySteel * 0.85,
      specificHeat: specificHeatSteel,
    );

    final tray = Body(
      name: 'tray',
      emissivity: emissivityOxidizedSteel,
      surfaceArea: 0.0819,
      mass: 0.5936,
      specificHeat: specificHeatSteel,
    );

    final drum = Body(
      name: 'drum',
      emissivity: emissivityOxidizedSteel,
      surfaceArea: 0.0316,
      mass: 0.3645,
      specificHeat: specificHeatSteel,
    );

    final air = Body(
      name: 'air',
      emissivity: 0.0,
      surfaceArea: 0.04, // surface area of doorway for when open.
      mass: 0.009 * densityAir,
      specificHeat: specificHeatAir,
    );

    final coffee = Coffee(
      mass: roastWeight,
    );

    final powerLevel = WattageNode(
      watts: 525 * 2 * _quartzEfficiency,
    );

    final powerInput = WattageEdge(
      from: powerLevel,
      to: quartzElement,
    );

    final baseEdges = [
      ...enclosure.radiate({Environment(): 1.0}),
      ConvectionEdge(
        from: quartzElement,
        to: air,
        heatTransferCoefficient: 1.0,
      ),
      ConvectionEdge(
        from: enclosure,
        to: air,
        heatTransferCoefficient: 1.0,
      ),
    ];

    final standardEnclosureConvection = ConvectionEdge(
      from: enclosure,
      to: Environment(),
      heatTransferCoefficient: 5,
    );

    final openEnclosureConvection = ConvectionEdge(
      from: enclosure,
      to: Environment(),
      heatTransferCoefficient: 8,
    );

    final preheatingGraph = ThermodynamicGraph([
      powerInput,
      ...quartzElement.radiate({enclosure: 1.0}),
      ...baseEdges,
      standardEnclosureConvection,
    ]);

    final doorOpenGraph = ThermodynamicGraph([
      ...baseEdges,
      ConvectionEdge(
        from: quartzElement,
        to: Environment(),
        heatTransferCoefficient: 0.5,
      ),
      openEnclosureConvection,
      ...quartzElement.radiate({
        enclosure: 0.9,
        Environment(): 0.0,
      }),
      ConvectionEdge(
        from: air,
        to: Environment(),
        heatTransferCoefficient: 10,
      ),
    ]);

    final roastingGraph = ThermodynamicGraph([
      powerInput,
      ...baseEdges,
      ...quartzElement.radiate({
        enclosure: 0.85,
        coffee: 0.15,
      }),
      ...drum.radiate({
        coffee: 1.0, // internal surface
        enclosure: 1.0, // external surface
      }),
      ...coffee.radiate({
        drum: 0.1,
        enclosure: 0.9,
      }),
      ...tray.radiate({enclosure: 1.0}),
      ...enclosure.radiate({
        drum: 0.1,
        coffee: 0.2,
        tray: 0.3,
      }),
      ConvectionEdge(
        from: coffee,
        to: air,
        heatTransferCoefficient: 1.5,
      ),
      standardEnclosureConvection,
    ]);

    final roastingWithFanGraph = ThermodynamicGraph([
      ...roastingGraph.edges,
      ConvectionEdge(
        from: enclosure,
        to: Environment(),
        heatTransferCoefficient: 10,
      ),
      ConvectionEdge(
        from: coffee,
        to: air,
        heatTransferCoefficient: 3,
      ),
    ]);

    return RoasterThermals._(
      quartzElement: quartzElement,
      enclosure: enclosure,
      coffee: coffee,
      powerInput: powerInput,
      roastingGraph: roastingGraph,
      roastingWithFanGraph: roastingWithFanGraph,
      preheatingGraph: preheatingGraph,
      openDoorGraph: doorOpenGraph,
    );
  }

  void setPowerLevel(double level) {
    powerInput.factor = level;
  }
}

class Coffee extends Body {
  Coffee({
    required double mass,
  }) : super(
          mass: mass,
          surfaceArea: 0.4 * mass,
          emissivity: emissivityCoffee,
          specificHeat: specificHeatCoffee,
          name: 'coffee',
        );

  @override
  double get specificHeat {
    // Apparent specific heat by temperature sourced from this article:
    // https://www.tandfonline.com/doi/full/10.1081/JFP-200048060
    const endothermStart = 373;
    const endothermEnd = 500; // actual 518, but steeper than linear.
    final endothermicProgress =
        (1 - ((tempK - endothermStart) / (endothermEnd - endothermStart)))
            .clamp(0.0, 1.0);
    // Basic linear slope that switches on at start.
    final thermalDecomp = tempK < 373 ? 0 : 689 * 2 * endothermicProgress;

    // The above article measured dehydrated coffee. For us, assume we vaporize
    // 9% of the coffee's weight (at 2260000J/Kg) from room temp to 300degF.
    // Basic constant rate.
    final vaporization =
        tempK < dryTempK ? 2260000 * mass * 0.09 / (dryTempK - roomTempK) : 0;
    return specificHeatCoffee + thermalDecomp + vaporization;
  }
}
