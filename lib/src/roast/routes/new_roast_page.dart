import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_config.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewRoastPage extends ConsumerStatefulWidget {
  const NewRoastPage({Key? key}) : super(key: key);

  @override
  NewRoastPageState createState() => NewRoastPageState();
}

class NewRoastPageState extends ConsumerState<NewRoastPage> {

  final name = TextEditingController();
  final number = TextEditingController(text: '1');
  final weight = TextEditingController(text: '300');
  final devel = TextEditingController(text: '20');
  final roastFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              const Text('Bean Name'),
              TextFormField(
                controller: name,
                validator: (value) {
                  if (value?.trim() == '') {
                    return 'Enter a bean name.';
                  }

                  return null;
                }
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
                  if (roastFormKey.currentState!.validate()) {
                    final roast = Roast(
                      bean: Bean(name: name.text),
                      roastNumber: int.parse(number.text),
                      weightIn: double.parse(weight.text),
                      weightOut: double.parse(weight.text),
                      config: RoastConfig(
                        tempInterval: 30,
                        targetDevelopment: double.parse(devel.text),
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
