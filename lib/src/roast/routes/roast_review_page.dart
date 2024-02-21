import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/roast/widgets/temp_log_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
  bool showPrev = false;
  bool showNext = false;
  List<Roast> roasts = const [];

  @override
  void initState() {
	super.initState();

    pageController.addListener(pageControllerUpdate);
  }

  @override
  void dispose() {
	super.dispose();
	pageController.dispose();
  }

  void pageControllerUpdate() {
	setState(() {
	  showPrev = pageController.page != 0;
	  showNext = pageController.page! < roasts.length - 1;
	});
  }

  @override
  Widget build(BuildContext context) {
	final roasts = ref.watch(roastsForBeanProvider(widget.beanId)).value ?? [];
	if (roasts.length > this.roasts.length) {
	  showNext = roasts.length > 1;
	}
	this.roasts = roasts;
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
	  floatingActionButton: Stack(
	    children: [
		  Align(
		    alignment: Alignment.bottomLeft,
			child: Container(
			  padding: const EdgeInsets.only(left: 30),
			  child: AnimatedOpacity(
			    duration: const Duration(milliseconds: 150),
			    opacity: showPrev ? 1.0 : 0.0,
			    child: FloatingActionButton(
				  heroTag: 'fab2',
				  onPressed: () {
					pageController.previousPage(
					  duration: const Duration(milliseconds: 200),
					  curve: Curves.easeInOut,
					);
				  },
				  child: const Icon(Icons.navigate_before),
				),
			  ),
			),
		  ),
		  Align(
		    alignment: Alignment.bottomRight,
			child: AnimatedOpacity(
			  duration: const Duration(milliseconds: 150),
			  opacity: showNext ? 1.0 : 0.0,
			  child: FloatingActionButton(
				onPressed: () {
				  pageController.nextPage(
					duration: const Duration(milliseconds: 200),
					curve: Curves.easeInOut,
				  );
				},
				child: const Icon(Icons.navigate_next),
			  ),
			),
		  ),
		],
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
	final dateFormat = DateFormat.yMd();
	return Column(
	  children: [
	    Text(
		  'Roast #${roast.roastNumber}',
		  style: RoastAppTheme.materialTheme.textTheme.subtitle1,
		),
	    Text(
		  'Roasted: ${dateFormat.format(roast.roasted)}',
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
