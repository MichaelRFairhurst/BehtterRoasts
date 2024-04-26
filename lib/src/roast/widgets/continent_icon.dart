import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContinentIcon extends StatelessWidget {
  const ContinentIcon(
    this.continent, {
    this.height = 36,
    super.key,
  });

  final double height;
  final Continent continent;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        beanIconPath(),
        color: RoastAppTheme.capuccinoLightest,
        height: height,
      );

  String beanIconPath() {
    switch (continent) {
      case Continent.africa:
        return 'images/africa.svg';
      case Continent.southAmerica:
        return 'images/south_america.svg';
      case Continent.centralAmerica:
        return 'images/central_america.svg';
      case Continent.other:
        return 'images/bean.svg';
    }
  }
}
