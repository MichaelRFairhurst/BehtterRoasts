import 'package:behmor_roast/src/thermodynamics/models/graph.dart';
import 'package:behmor_roast/src/thermodynamics/models/materials.dart';

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
  final ThermodynamicGraph preheatingGraph;
  final ThermodynamicGraph openDoorGraph;

  RoasterThermals._({
    required this.quartzElement,
    required this.enclosure,
	required this.coffee,
    required this.powerInput,
    required this.roastingGraph,
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
      surfaceArea: _enclosureSA * 0.85,
      mass: _enclosureSA * _enclosureThickness * densitySteel * 1,
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

    //final air = Body(
	//  emissivity: 0.0,
	//  surfaceArea: 0.0,
	//  mass: 0.009 * densityAir,
	//  specificHeat: specificHeatAir,
	//);

    final coffee = Body(
	  name: 'coffee',
	  emissivity: emissivityCoffee,
	  surfaceArea: .4 * roastWeight,
	  mass: roastWeight,
	  specificHeat: specificHeatCoffee,
	);

    final powerLevel = WattageNode(
      watts: 525 * 2 * _quartzEfficiency * 1.05,
    );

    final powerInput = WattageEdge(
      from: powerLevel,
      to: quartzElement,
    );

    final baseEdges = [
	  ...enclosure.radiate({Environment(): 1.0}),
	];

    final standardEnclosureConvection =
      ConvectionEdge(
        from: enclosure,
        to: Environment(),
		heatTransferCoefficient: 5,
      );

    final openEnclosureConvection =
      ConvectionEdge(
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
	  standardEnclosureConvection,
    ]);

    return RoasterThermals._(
      quartzElement: quartzElement,
      enclosure: enclosure,
	  coffee: coffee,
      powerInput: powerInput,
      roastingGraph: roastingGraph,
	  preheatingGraph: preheatingGraph,
	  openDoorGraph: doorOpenGraph,
    );
  }

  void setPowerLevel(double level) {
    powerInput.factor = level;
  }
}

