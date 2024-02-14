import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_config.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/widgets/bean_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewRoastPage extends ConsumerStatefulWidget {
  const NewRoastPage({Key? key}) : super(key: key);

  @override
  NewRoastPageState createState() => NewRoastPageState();
}

class NewRoastPageState extends ConsumerState<NewRoastPage> {

  final number = TextEditingController(text: '1');
  final weight = TextEditingController(text: '300');
  final devel = TextEditingController(text: '20');
  final roastFormKey = GlobalKey<FormState>();

  Bean? selectedBean;
  bool beanErr = false;

  @override
  Widget build(BuildContext context) {
           final InputDecoration effectiveDecoration = const InputDecoration()
               .applyDefaults(Theme.of(context).inputDecorationTheme);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Start a New Roast"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: roastFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
			  if (beanErr)
				Text(
				  'Select a bean:',
				  style: RoastAppTheme.materialTheme.textTheme.caption!.copyWith(
				    color: RoastAppTheme.materialTheme.errorColor,
					fontSize: 12.0,
				  ),
				  //style: effectiveDecoration.labelStyle!.copyWith(fontSize: 12.0),
				),
			  BeanSelect(
			    selectedBean: selectedBean,
				onChanged: (bean) {
				  setState(() {
					selectedBean = bean;
				  });
				},
			  ),
              const SizedBox(height: 10),
              const Text('Roast number'),
              TextFormField(
                controller: number,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (int.tryParse(value ?? '') == null) {
                    return 'Enter a valid roast number';
                  }

                  return null;
                }
              ),
              const SizedBox(height: 10),
              const Text('Weight (g)'),
              TextFormField(
                controller: weight,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  suffixText: 'g',
                ),
                validator: (value) {
                  if (double.tryParse(value ?? '') == null) {
                    return 'Enter a valid weight';
                  }

                  return null;
                }
              ),
              const Text('Target Development (%)'),
              TextFormField(
                controller: devel,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  suffixText: '%',
                ),
                validator: (value) {
                  if (double.tryParse(value ?? '') == null) {
                    return 'Enter a valid development percentage';
                  }

                  return null;
                }
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_circle),
                label: const Text('Begin roast'),
                onPressed: () {
				  final formValid = roastFormKey.currentState!.validate();
				  if (selectedBean == null) {
					setState(() {
					  beanErr = true;
					});
				  } else {
					setState(() {
					  beanErr = false;
					});
				  }

                  if (!beanErr && formValid) {
                    final roast = Roast(
                      beanId: selectedBean!.id!,
                      roastNumber: int.parse(number.text),
                      weightIn: double.parse(weight.text),
                      weightOut: double.parse(weight.text),
                      config: RoastConfig(
                        tempInterval: 30,
                        targetDevelopment: double.parse(devel.text) / 100,
                      ),
                    );
                    ref.read(roastProvider.notifier).state = roast;
				    context.go(Routes.timer, extra: roast);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
