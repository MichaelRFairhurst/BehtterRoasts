import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/services/bean_service.dart';
import 'package:behmor_roast/src/roast/widgets/continent_icon.dart';
import 'package:behmor_roast/src/sign_in/providers.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
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
  bool expand = false;
  final newBeanName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final beans = ref
            .watch(beansProvider)
            .value
            ?.where((bean) => !bean.archived)
            .toList() ??
        [];
    final beanService = ref.watch(beanServiceProvider);

    if (widget.selectedBean != null && !beans.contains(widget.selectedBean)) {
      beans.add(widget.selectedBean!);
      addNew = true;
    }

    final selectedContinent = widget.selectedBean == null
        ? Continent.other
        : beanService.continentOf(widget.selectedBean!);

    if (addNew || beans.isEmpty) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                label: const Text('New Bean Name'),
                border: InputBorder.none,
                icon: continentAddIcon(selectedContinent),
              ),
              controller: newBeanName,
              onChanged: (_) => selectNewBean(),
              autofocus: true,
              validator: (value) {
                if (value == '') {
                  return 'Enter a bean name';
                }

                return null;
              },
            ),
          ),
          if (beans.isNotEmpty && !addNew || beans.length > 1 && addNew)
            SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                icon: const Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    addNew = false;
                  });
                  widget.onChanged(null);
                },
              ),
            ),
        ],
      );
    }

    return Column(
      children: [
        if (expand || widget.selectedBean == null)
          tile(
            title: const Text('Select a bean'),
            leading: ContinentIcon(
              Continent.other,
              height: 24,
              color: Theme.of(context).inputDecorationTheme.iconColor,
            ),
            isHeading: true,
            onTap: () {
              setState(() {
                expand = !expand;
              });
            },
          )
        else
          beanTile(widget.selectedBean!, beanService, true),
        AnimatedPopUp(
          child: !expand
              ? const SizedBox()
              : Column(
                  children: getItems(beans, beanService),
                ),
        ),
      ],
    );
  }

  void selectNewBean() {
    widget.onChanged(Bean(
      name: newBeanName.text,
      ownerId: ref.read(authProvider).value!.uid,
    ));
  }

  Widget beanTile(Bean bean, BeanService beanService, bool isHeading) {
    return tile(
      leading: Hero(
        tag: '${bean.name}Icon',
        child: ContinentIcon(
          beanService.continentOf(bean),
          height: isHeading ? 24 : 20,
          color: Theme.of(context).inputDecorationTheme.iconColor,
        ),
      ),
      title: Hero(
        tag: bean.name,
        child: Text(bean.name,
            style: isHeading
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 13)),
      ),
      isHeading: isHeading,
      onTap: isHeading
          ? () {
              setState(() {
                expand = !expand;
              });
            }
          : () {
              setState(() {
                expand = !expand;
              });
              widget.onChanged(bean);
            },
    );
  }

  Widget tile({
    required Widget title,
    required Widget leading,
    required bool isHeading,
    required void Function() onTap,
  }) {
    return ListTile(
      title: title,
      leading: leading,
      contentPadding:
          isHeading ? const EdgeInsets.all(0) : const EdgeInsets.only(left: 12),
      trailing: isHeading ? const Icon(Icons.expand_more) : null,
      dense: !isHeading,
      onTap: onTap,
    );
  }

  List<Widget> getItems(List<Bean> beans, BeanService beanService) {
    return [
      ...beans.map((bean) => beanTile(bean, beanService, false)),
      Text(
        'or',
        style: RoastAppTheme.materialTheme.textTheme.bodySmall,
      ),
      const SizedBox(height: 6),
      ListTileTheme(
        data: ListTileThemeData(
          iconColor: RoastAppTheme.capuccino,
          textColor: RoastAppTheme.capuccino,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          tileColor: RoastAppTheme.lime,
        ),
        child: tile(
          title: const Text('Add new bean'),
          leading: continentAddIcon(Continent.other),
          isHeading: false,
          onTap: () {
            setState(() {
              addNew = true;
            });
            selectNewBean();
          },
        ),
      ),
      const SizedBox(height: 8),
    ];
  }

  Widget continentAddIcon(Continent selectedContinent) {
    const iconRight = 0.0;
    const iconBottom = 0.0;
    return Container(
      alignment: Alignment.center,
      height: 24,
      width: 24,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ContinentIcon(
              selectedContinent,
              height: 20,
            ),
            for (double right = iconRight - 1.5;
                right <= iconRight + 1.5;
                right += 1)
              for (double bottom = iconBottom - 1.5;
                  bottom <= iconBottom + 1.5;
                  bottom += 1)
                Positioned(
                  right: right,
                  bottom: bottom,
                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                ),
            const Positioned(
              right: iconRight,
              bottom: iconBottom,
              child: Icon(Icons.add, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
