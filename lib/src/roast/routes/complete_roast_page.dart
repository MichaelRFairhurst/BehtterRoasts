import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/widgets/roast_summary_widget.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/widgets/roast_pop_scope.dart';
import 'package:behmor_roast/src/util/logo_title.dart';
import 'package:behmor_roast/src/util/widgets/fill_or_scroll.dart';
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
    return RoastPopScope(
      state: RoastState.done,
      child: Scaffold(
        appBar: AppBar(
          title: const LogoTitle('Roast complete'),
        ),
        body: FillOrScroll(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
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
                const Spacer(),
                if (needsWeightOut) ...[
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
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.text_snippet),
                      labelText: 'Roast notes',
                    ),
                    onChanged: (str) {
                      ref
                          .read(roastProvider.notifier)
                          .update((roast) => roast!.copyWith(
                                notes: str,
                              ));
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: RoastAppTheme.limeButtonTheme.style,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final weightOut = double.parse(weightOutCtrl.text);
                        ref
                            .read(roastProvider.notifier)
                            .update((roast) => roast!.copyWith(
                                  weightOut: weightOut,
                                ));
                        setState(() {
                          needsWeightOut = false;
                        });
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Done'),
                  ),
                ],
                if (!needsWeightOut)
                  RoastSummaryWidget(summary: ref.watch(roastSummaryProvider)!),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
        floatingActionButton: needsWeightOut
            ? null
            : ElevatedButton.icon(
                style: RoastAppTheme.largeButtonTheme.style,
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Save Roast'),
                onPressed: () {
                  final roast = ref.read(roastProvider)!;
                  final roastService = ref.read(roastServiceProvider);
                  roastService.add(roast);
                  context.pop();
                },
              ),
      ),
    );
  }
}
