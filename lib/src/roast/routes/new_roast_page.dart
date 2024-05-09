import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_config.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/services/roast_number_service.dart';
import 'package:behmor_roast/src/roast/widgets/bean_select.dart';
import 'package:behmor_roast/src/roast/widgets/temp_interval_select.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/util/logo_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewRoastPage extends ConsumerStatefulWidget {
  const NewRoastPage({Key? key, this.selectedBean}) : super(key: key);

  final Bean? selectedBean;

  @override
  NewRoastPageState createState() => NewRoastPageState();
}

class NewRoastPageState extends ConsumerState<NewRoastPage> {
  final weight = TextEditingController(text: '300');
  final devel = TextEditingController(text: '20');
  final roastFormKey = GlobalKey<FormState>();
  int tempInterval = 30;

  Bean? selectedBean;
  bool beanErr = false;

  @override
  void initState() {
    super.initState();
    selectedBean = widget.selectedBean;
    final copy = ref.read(copyOfRoastProvider);
    if (copy != null) {
      devel.text = (copy.config.targetDevelopment * 100).toString();
      weight.text = copy.weightIn.toString();
      tempInterval = copy.config.tempInterval;
      final beans = ref.read(beansProvider);
      beans.whenData((beans) {
        setState(() {
          selectedBean = beans.singleWhere((bean) => bean.id == copy.beanId);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final copy = ref.watch(copyOfRoastProvider);
    final beans = ref.watch(beansProvider);
    final bean = beans.valueOrNull
        ?.cast<Bean?>()
        .singleWhere((bean) => bean?.id == copy?.beanId, orElse: () => null);
    final otherRoasts = selectedBean == null
        ? <Roast>[]
        : ref.watch(roastsForBeanProvider(selectedBean!.id!)).value ?? [];

    final roastNumber =
        RoastNumberService().getNewRoastNumber(copy?.id, otherRoasts);

    return Scaffold(
      appBar: AppBar(
        title: const LogoTitle("New Roast"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: roastFormKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      'Beans:',
                      style: RoastAppTheme.materialTheme.textTheme.titleMedium,
                    ),
                    _beansFormCard(),
                    if (selectedBean != null)
                      Text('Roast ID: ${selectedBean!.name} #$roastNumber',
                          textAlign: TextAlign.center),
                    const SizedBox(height: 40),
                    Text(
                      'Profile:',
                      style: RoastAppTheme.materialTheme.textTheme.titleMedium,
                    ),
                    _profileFormCard(bean, copy),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          label: const Icon(Icons.navigate_next),
                          icon: const Text('Begin roast'),
                          onPressed: () {
                            final formValid =
                                roastFormKey.currentState!.validate();
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
                                copyOfRoastId: copy?.id,
                                roasted: DateTime.now(), // Replaced later.
                                roastNumber: roastNumber,
                                weightIn: double.parse(weight.text),
                                weightOut: double.parse(weight.text),
                                config: RoastConfig(
                                  tempInterval: tempInterval,
                                  targetDevelopment:
                                      double.parse(devel.text) / 100,
                                ),
                              );
                              ref.read(roastProvider.notifier).state = roast;
                              ref.read(roastTimelineProvider.notifier).state =
                                  const RoastTimeline(rawLogs: []);
                              ref.read(roastTimerProvider).reset();
                              ref.read(preheatTimerProvider).reset();
                              context.replace(Routes.timer);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _beansFormCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            if (beanErr)
              Text(
                'Select a bean:',
                style: RoastAppTheme.materialTheme.textTheme.caption!.copyWith(
                  color: RoastAppTheme.materialTheme.errorColor,
                  fontSize: 12.0,
                ),
              ),
            BeanSelect(
              selectedBean: selectedBean,
              onChanged: (bean) {
                setState(() {
                  selectedBean = bean;
                });
              },
            ),
            _label('Weight (g)'),
            TextFormField(
              controller: weight,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixText: 'g',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.scale),
              ),
              validator: (value) {
                if (double.tryParse(value ?? '') == null) {
                  return 'Enter a valid weight';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Row(
      children: [
        Text(text),
        const SizedBox(width: 12),
        const Expanded(
          child: Divider(),
        ),
      ],
    );
  }

  Widget _profileFormCard(Bean? bean, Roast? copy) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _label('Target Development (%)'),
            TextFormField(
              controller: devel,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixText: '%',
                border: InputBorder.none,
                icon: Icon(Icons.speed),
              ),
              validator: (value) {
                if (double.tryParse(value ?? '') == null) {
                  return 'Enter a valid development percentage';
                }

                return null;
              },
            ),
            _label('Check temperature:'),
            Row(
              children: [
                const Icon(Icons.timer),
                Expanded(
                  child: TempIntervalSelect(
                    value: tempInterval,
                    onChanged: (val) {
                      setState(() {
                        tempInterval = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            _label('Copy of roast:'),
            if (copy != null && bean != null)
              InputChip(
                label: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text('Copying '),
                    Flexible(
                      child: Text(bean.name, overflow: TextOverflow.ellipsis),
                    ),
                    Text(' roast #${copy.roastNumber}'),
                  ],
                ),
                onDeleted: () {
                  ref.read(copyOfRoastProvider.notifier).state = null;
                },
              )
            else
              const Text('None'),
          ],
        ),
      ),
    );
  }
}
