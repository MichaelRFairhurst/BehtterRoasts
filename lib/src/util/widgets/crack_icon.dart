import 'package:flutter/material.dart';

class CrackIcon extends StatelessWidget {
  const CrackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
	const dTotal = 12.0;
	const dHalf = 6.0;
    final semicircle = Container(
	  height: dTotal,
	  width: dHalf,
	  decoration: const BoxDecoration(
	    color: Colors.black,
	    borderRadius: BorderRadius.only(
		  topRight: Radius.circular(dHalf),
		  bottomRight: Radius.circular(dHalf),
		)
	  ),
	);

    return Stack(
	  children: [
	    const SizedBox(width: dTotal + 2, height: dTotal + 1),
		Positioned(
		  left: 1,
		  top: 0,
	      child: Transform.rotate(
		    angle: 0.5,
			alignment: Alignment.bottomLeft,
		    child: semicircle,
		  ),
		),
		Positioned(
		  left: 0,
		  top: 0,
	      child: Transform.rotate(
		    angle: 0.3,
			alignment: Alignment.bottomLeft,
		    child: Transform.scale(scaleX: -1, alignment: Alignment.centerLeft, child: semicircle),
		  ),
		),
	  ],
	);
  }
}
