import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/widgets/temp_log_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoastReviewPage extends ConsumerStatefulWidget {

  const RoastReviewPage({
    required this.beanId,
	super.key,
  });

  final String beanId;

  @override
  RoastReviewPageState createState() => RoastReviewPageState();
}

class RoastReviewPageState extends ConsumerState<RoastReviewPage> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
	final roasts = ref.watch(roastsForBeanProvider(widget.beanId)).value ?? [];
	final bean = ref.watch(beansProvider).value?.singleWhere((bean) => bean.id == widget.beanId);
	final roastLogService = ref.watch(roastLogServiceProvider);
	if (bean == null) {
	  return Container();
	}

	return Scaffold(
	  appBar: AppBar(
	    title: Text('Roasts (${bean.name})'),
	  ),
	  body: PageView(
	    controller: pageController,
		children: roasts.map((roast) {
		  return Container(
		    alignment: Alignment.center,
		    child: TempLogWidget(
			  logs: roastLogService.aggregate(
			    roast.tempLogs,
				roast.phaseLogs,
				roast.controlLogs,
			  ),
			),
		  );
		}).toList(),
	  ),
	);
  }
}
