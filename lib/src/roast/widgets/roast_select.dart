import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class RoastSelect extends ConsumerStatefulWidget {
  const RoastSelect({
    required this.title,
    required this.bean,
    required this.selectedRoast,
    required this.onChanged,
    super.key,
  });

  final Widget title;
  final Bean? bean;
  final Roast? selectedRoast;
  final void Function(Roast?) onChanged;

  @override
  RoastSelectState createState() => RoastSelectState();
}

class RoastSelectState extends ConsumerState<RoastSelect> {
  bool expand = false;
  final newBeanName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var roasts = widget.bean?.id == null
        ? <Roast>[]
        : ref.watch(roastsForBeanProvider(widget.bean!.id!)).value ?? [];
    final allBeans = ref.watch(beansProvider).value ?? [];

    if (widget.selectedRoast != null &&
        !roasts.contains(widget.selectedRoast)) {
      roasts = [widget.selectedRoast!, ...roasts];
    }

    if (widget.bean == null || roasts.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        widget.title,
        if (expand || widget.selectedRoast == null)
          tile(
            title: const Text('(optional)'),
            subtitle: 'Choose a roast to repeat.',
            leading: SvgPicture.asset(
              'images/copy_roast3.svg',
              color: RoastAppTheme.materialTheme.inputDecorationTheme.iconColor,
              width: 24,
            ),
            isHeading: true,
            onTap: () {
              setState(() {
                expand = !expand;
              });
            },
          )
        else
          roastTile(widget.selectedRoast!, allBeans, true),
        AnimatedPopUp(
          child: !expand
              ? const SizedBox()
              : Column(
                  children: getItems(roasts, allBeans),
                ),
        ),
      ],
    );
  }

  Widget roastTile(Roast roast, List<Bean> beans, bool isHeading) {
    final bean = beans.firstWhere((bean) => bean.id == roast.beanId);
    final timeline = roast.toTimeline();
    return tile(
      leading: SvgPicture.asset(
        'images/beans.svg',
        height: isHeading ? 28 : 24,
        color: Theme.of(context).inputDecorationTheme.iconColor,
      ),
      title: Row(
        children: [
          Text('Roast #${roast.roastNumber} (${roast.weightIn}g, '),
          TimestampWidget(timeline.done!),
          const Text(')'),
        ],
      ),
      subtitle: bean.name,
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
              widget.onChanged(roast);
            },
    );
  }

  Widget tile({
    required Widget title,
    required String subtitle,
    required Widget leading,
    required bool isHeading,
    void Function()? onTap,
  }) {
    return ListTile(
      title: title,
      leading: leading,
      subtitle: Text(subtitle),
      contentPadding:
          isHeading ? const EdgeInsets.all(0) : const EdgeInsets.only(left: 12),
      trailing: isHeading ? const Icon(Icons.expand_more) : null,
      dense: !isHeading,
      onTap: onTap,
    );
  }

  List<Widget> getItems(List<Roast> roasts, List<Bean> allBeans) {
    return [
      ...roasts.map((roast) => roastTile(roast, allBeans, false)),
      tile(
        title: const Text('None'),
        subtitle: 'Do not repeat a previous roast.',
        onTap: () {
          setState(() {
            expand = false;
          });
          widget.onChanged(null);
        },
        leading: Icon(
          Icons.cancel,
          color: RoastAppTheme.materialTheme.inputDecorationTheme.iconColor,
        ),
        isHeading: false,
      ),
    ];
  }
}
