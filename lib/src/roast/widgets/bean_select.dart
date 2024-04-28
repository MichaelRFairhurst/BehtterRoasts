import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/sign_in/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BeanSelect extends ConsumerStatefulWidget {
  const BeanSelect({
    required this.selectedBean,
    required this.onChanged,
    super.key,
  });

  final Bean? selectedBean;
  final void Function(Bean?) onChanged;

  @override
  BeanSelectState createState() => BeanSelectState();
}

class BeanSelectState extends ConsumerState<BeanSelect> {
  bool addNew = false;
  final newBeanName = TextEditingController();
  final newBeanForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final beans = ref
            .watch(beansProvider)
            .value
            ?.where((bean) => !bean.archived)
            .toList() ??
        [];

    if (widget.selectedBean != null && !beans.contains(widget.selectedBean)) {
      beans.add(widget.selectedBean!);
    }

    if (addNew) {
      return Form(
        key: newBeanForm,
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Bean name'),
                    ),
                    controller: newBeanName,
                    validator: (value) {
                      if (value == '') {
                        return 'Enter a bean name';
                      }

                      return null;
                    })),
            ElevatedButton(
              style: RoastAppTheme.limeButtonTheme.style,
              onPressed: () async {
                if (newBeanForm.currentState!.validate()) {
                  final bean = await ref.read(beanServiceProvider).add(Bean(
                        name: newBeanName.text,
                        ownerId: ref.read(authProvider).value!.uid,
                      ));
                  addNew = false;
                  widget.onChanged(bean);
                }
              },
              child: const Icon(Icons.check),
            ),
            const SizedBox(width: 4.0),
            ElevatedButton(
              style: RoastAppTheme.cancelButtonTheme.style,
              onPressed: () {
                setState(() {
                  addNew = false;
                });
              },
              child: const Icon(Icons.cancel),
            ),
          ],
        ),
      );
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.0,
      children: [
        const Text('Bean:'),
        DropdownButton<Bean>(
          value: widget.selectedBean,
          items: getItems(beans),
          onChanged: widget.onChanged,
        ),
        const Text('OR'),
        ElevatedButton.icon(
          label: const Text('Add new bean'),
          icon: const Icon(Icons.add),
          style: RoastAppTheme.limeButtonTheme.style,
          onPressed: () {
            widget.onChanged(null);
            setState(() {
              addNew = true;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<Bean>> getItems(List<Bean> beans) {
    if (beans.isEmpty) {
      return [
        const DropdownMenuItem<Bean>(
          value: null,
          child: Text('None'),
        )
      ];
    }

    return [
      ...beans.map((bean) => DropdownMenuItem<Bean>(
            value: bean,
            child: Text(bean.name),
          )),
      if (widget.selectedBean == null)
        const DropdownMenuItem<Bean>(
          value: null,
          child: Text('Select a bean'),
        ),
    ];
  }
}
