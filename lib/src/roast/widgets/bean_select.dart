import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/sign_in/providers.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

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
  bool expand = false;
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

    return Column(
      children: [
        ListTile(
          title: Text(widget.selectedBean?.name ?? 'Select a bean'),
          leading: SvgPicture.asset(
            'images/bean.svg',
            color: RoastAppTheme.capuccinoLight,
            height: 24,
          ),
          contentPadding: const EdgeInsets.only(left: 12),
          horizontalTitleGap: 0.0,
          trailing: const Icon(Icons.expand_more),
          onTap: () {
            setState(() {
              expand = true;
            });
          },
        ),
        AnimatedPopUp(
          child: !expand
              ? const SizedBox()
              : Column(
                  children: getItems(beans),
                ),
        ),
      ],
    );
  }

  Widget beanTile(Bean bean) {
    return ListTile(
      title: Text(bean.name),
      leading: SvgPicture.asset(
        'images/bean.svg',
        color: RoastAppTheme.capuccinoLight,
        height: 24,
      ),
      contentPadding: const EdgeInsets.only(left: 12),
      horizontalTitleGap: 0.0,
      trailing: expand ? null : const Icon(Icons.expand_more),
      dense: true,
      onTap: () {
        if (expand) {
          widget.onChanged(bean);
        }
        setState(() {
          expand = !expand;
        });
      },
    );
  }

  List<Widget> getItems(List<Bean> beans) {
    if (beans.isEmpty) {
      return [
        const Text('None'),
      ];
    }

    return beans.map((bean) => beanTile(bean)).toList();
  }
}
