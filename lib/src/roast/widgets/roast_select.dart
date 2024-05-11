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
    final roasts = widget.bean?.id == null
        ? <Roast>[]
        : ref.watch(roastsForBeanProvider(widget.bean!.id!)).value ?? [];

    if (widget.bean == null || roasts.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        widget.title,
        if (expand || widget.selectedRoast == null)
          tile(
            title: const Text('(optional)'),
            subtitle: 'Choose a roast to copy.',
            leading: Icon(
              Icons.restart_alt,
              color: RoastAppTheme.materialTheme.inputDecorationTheme.iconColor,
            ),
            isHeading: true,
            onTap: () {
              setState(() {
                expand = !expand;
              });
            },
          )
        else
          roastTile(widget.selectedRoast!, true),
        AnimatedPopUp(
          child: !expand
              ? const SizedBox()
              : Column(
                  children: getItems(roasts),
                ),
        ),
      ],
    );
  }

  Widget roastTile(Roast roast, bool isHeading) {
    final timeline = roast.toTimeline();
    return tile(
      leading: SvgPicture.asset(
        'images/beans.svg',
        height: isHeading ? 24 : 20,
        color: Theme.of(context).inputDecorationTheme.iconColor,
      ),
      title: Row(
        children: [
          Text('Roast #${roast.roastNumber} ('),
          TimestampWidget(timeline.done!),
          const Text(')'),
        ],
      ),
      subtitle: widget.bean!.name, //roast.roastNumber,
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
      contentPadding: const EdgeInsets.only(left: 12),
      horizontalTitleGap: 0.0,
      trailing: isHeading ? const Icon(Icons.expand_more) : null,
      dense: !isHeading,
      onTap: onTap,
    );
  }

  List<Widget> getItems(List<Roast> roasts) {
    return [
      ...roasts.map((roast) => roastTile(roast, false)),
      tile(
        title: const Text('None'),
        subtitle: 'Do not copy a previous roast.',
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
