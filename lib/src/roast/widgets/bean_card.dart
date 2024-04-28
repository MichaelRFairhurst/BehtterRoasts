import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/services/bean_service.dart';
import 'package:behmor_roast/src/roast/widgets/continent_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BeanCard extends StatelessWidget {
  const BeanCard({
    required this.bean,
    required this.beanService,
    super.key,
  });

  final Bean bean;
  final BeanService beanService;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: InkWell(
        onTap: () {
          context.push(Routes.roastTimeline(bean.id!));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Hero(
                tag: '${bean.name}Icon',
                child: ContinentIcon(beanService.continentOf(bean)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Hero(
                  tag: bean.name,
                  child: Text(bean.name,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
            ),
            PopupMenuButton<void>(
              itemBuilder: (context) {
                return <PopupMenuItem<void>>[
                  PopupMenuItem<void>(
                    child: TextButton.icon(
                      icon: const Icon(Icons.archive),
                      label: Text(bean.archived ? 'Unarchive' : 'Archive'),
                      onPressed: () {
                        beanService
                            .update(bean.copyWith(archived: !bean.archived));
                      },
                    ),
                  ),
                  PopupMenuItem<void>(
                    child: TextButton.icon(
                      icon: const Icon(Icons.timeline),
                      label: const Text('Timeline'),
                      onPressed: () {
                        context.push(Routes.roastTimeline(bean.id!));
                      },
                    ),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert, color: RoastAppTheme.limeDark),
            ),
            const SizedBox(
              height: 56,
              child: VerticalDivider(width: 1),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  IconButton(
                    iconSize: 48,
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(Icons.local_fire_department_sharp),
                    color: RoastAppTheme.errorColor,
                    tooltip: 'Roast',
                    onPressed: () {
                      context.push(Routes.newRoast, extra: bean);
                    },
                  ),
                  Text(
                    'ROAST',
                    style: RoastAppTheme.materialTheme.textTheme.labelSmall
                        ?.copyWith(color: RoastAppTheme.errorColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
