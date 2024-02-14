import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/providers.dart';
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
	final beans = ref.watch(beansProvider).value ?? [];

    if (addNew) {
	  return Form(
	    key: newBeanForm,
		child: Row(
		  children: [
		    Expanded(child: TextFormField(
			  decoration: const InputDecoration(
				label: Text('Bean name'),
			  ),
			  controller: newBeanName,
			  validator: (value) {
				if (value == '') {
				  return 'Enter a bean name';
				}

				return null;
			  }
			)),
			ElevatedButton(
			  child: const Icon(Icons.check),
			  onPressed: () async {
				if (newBeanForm.currentState!.validate()) {
				  final bean = await ref.read(beanServiceProvider).add(Bean(name: newBeanName.text));
				  addNew = false;
                  widget.onChanged(bean);
				}
			  }
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
		  onPressed: () {
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
	  return [const DropdownMenuItem<Bean>(
	    value: null,
		child: Text('None'),
	  )];
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
