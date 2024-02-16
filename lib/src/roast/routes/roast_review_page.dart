import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
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
	    title: Text('Roasts for ${bean.name}'),
	  ),
	  body: PageView(
	    controller: pageController,
		children: getRoastPages(bean, roasts, roastLogService),
	  ),
	);
  }

  List<Widget> getRoastPages(Bean bean, List<Roast> roasts, RoastLogService roastLogService) {
	if (roasts.isEmpty) {
	  return const [noRoastsPage];
	}

    return roasts.map((roast) => singleRoastPage(bean, roast, roastLogService)).toList();
  }

  Widget singleRoastPage(Bean bean, Roast roast, RoastLogService roastLogService) {
	return Column(
	  children: [
	    Text(
		  'Roast #${roast.roastNumber}',
		  style: RoastAppTheme.materialTheme.textTheme.subtitle1,
		),
		Expanded(
		  child: SingleChildScrollView(
			child: TempLogWidget(
			  logs: roastLogService.aggregate(
				roast.tempLogs,
				roast.phaseLogs,
				roast.controlLogs,
			  ),
			),
		  ),
		),
	  ],
	);
  }

  static const noRoastsPage = Center(
	child: Text('No roasts yet.'),
  );
}
