import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/widgets/roast_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CompleteRoastPage extends ConsumerStatefulWidget {
  const CompleteRoastPage({super.key});

  @override
  CompleteRoastPageState createState() => CompleteRoastPageState();
}

class CompleteRoastPageState extends ConsumerState<CompleteRoastPage> {
  final weightOutCtrl = TextEditingController();
  bool needsWeightOut = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  appBar: AppBar(
	    title: const Text('Roast complete'),
	  ),
	  body: Padding(
	    padding: const EdgeInsets.all(24.0),
		child: Column(
		  crossAxisAlignment: CrossAxisAlignment.stretch,
		  mainAxisAlignment: MainAxisAlignment.center,
		  children: [
			Text(
			  'Mmmm, smells good!',
			  textAlign: TextAlign.center,
			  style: RoastAppTheme.materialTheme.textTheme.headlineLarge,
			),
			const SizedBox(height: 12),
			const Text(
			  "There's nothing like fresh roasted coffee.",
			  textAlign: TextAlign.center,
			),
			const SizedBox(height: 80),
			if (needsWeightOut)
			  Row(
				children: [
				  Form(
					key: formKey,
					child: Expanded(
					  child: TextFormField(
						controller: weightOutCtrl,
						validator: (val) {
						  if (val == '' || val == null) {
							return 'Enter weight';
						  }
						  if (double.tryParse(val) == null) {
							return 'Enter a valid weight';
						  }
						},
						keyboardType: TextInputType.number,
						decoration: const InputDecoration(
						  label: Text('Weigh your roast output (g)'),
						  suffixText: 'g',
						  prefixIcon: Icon(Icons.scale),
						),
					  ),
					),
				  ),
				  const SizedBox(width: 12),
				  ElevatedButton(
					style: RoastAppTheme.limeButtonTheme.style,
					onPressed: () {
					  if (formKey.currentState!.validate()) {
						final weightOut = double.parse(weightOutCtrl.text);
						ref.read(roastProvider.notifier).update((roast) => roast!.copyWith(
						  weightOut: weightOut,
						));
						setState(() {
						  needsWeightOut = false;
						});
					  }
					},
					child: const Icon(Icons.check),
				  )
				],
			  ),
            if (!needsWeightOut)
			  RoastSummaryWidget(summary: ref.watch(roastSummaryProvider)!),
		  ],
		),
	  ),
	  floatingActionButton: needsWeightOut ? null : ElevatedButton.icon(
	    style: RoastAppTheme.largeButtonTheme.style,
		icon: const Icon(Icons.cloud_upload),
		label: const Text('Save Roast'),
		onPressed: () {
		  final roastService = ref.read(roastServiceProvider);
		  roastService.add(ref.read(roastProvider)!);
		  context.pop();
		},
	  ),
	);
  }
}
