import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/timer/models/alert.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({
	required this.alerts,
	super.key,
  });

  final List<Alert> alerts;

  @override
  AlertWidgetState createState() => AlertWidgetState();
}

class AlertWidgetState extends State<AlertWidget> {

  var alerts = <Alert>[];
  final dismissed = <Severity, Set<AlertKind>>{
	Severity.warning: <AlertKind>{},
	Severity.alert: <AlertKind>{},
  };

  @override
  void initState() {
	super.initState();
	_refreshAlerts();
  }

  @override
  void didUpdateWidget(AlertWidget oldWidget) {
	super.didUpdateWidget(oldWidget);

    _refreshAlerts();
  }

  void _refreshAlerts() {
	// Allow dismissed warnings to reappear when re-warned.
	_pruneDismissals();

    // Dismissed warnings blocks all alerts of that type; filter.
    final baseAlerts = widget.alerts.where(
	    (a) => !dismissed[Severity.warning]!.contains(a.kind));

    final newWarnings = baseAlerts.where((a) => a.severity == Severity.warning);
    final newAlerts = baseAlerts.where((a) => a.severity == Severity.alert)
	    .where((a) => !dismissed[Severity.alert]!.contains(a.kind));

	final kindsState = buildAlertKindsMap();

	// Beep for new warnings.
    for (final warning in newWarnings) {
      final oldWarning = kindsState[warning.kind];
	  if (oldWarning == null || oldWarning.severity != warning.severity) {
		FlutterBeep.beep(false);
	  }
	}

	// Beep for new alerts..
    for (final alert in newAlerts) {
      final oldAlert = kindsState[alert.kind];
	  if (oldAlert == null) {
		FlutterBeep.beep(false);
	  }
	}

    // Update alerts, removing dismissed items.
	alerts = [...newWarnings, ...newAlerts];
  }

  Map<AlertKind, Alert> buildAlertKindsMap() {
	final pairs = alerts.map((alert) => MapEntry(alert.kind, alert));
	return Map<AlertKind, Alert>.fromEntries(pairs);
  }

  void _pruneDismissals() {
	final kindsWidget = widget.alerts.map((alert) => alert.kind).toSet();

	dismissed[Severity.warning]!
		.removeWhere((kind) => !kindsWidget.contains(kind));
	dismissed[Severity.alert]!
		.removeWhere((kind) => !kindsWidget.contains(kind));
  }

  @override
  Widget build(BuildContext context) {
	if (alerts.isEmpty) {
	  return const AnimatedPopUp(child: null);
	}
	final alert = alerts.first;
	final severity = alert.severity == Severity.warning ? 'Warning' : 'Alert';
	final color = alert.severity == Severity.warning
	    ? RoastAppTheme.errorColor
		: RoastAppTheme.alertColor;
	return AnimatedPopUp(
	  child: Container(
	    key: Key(alert.kind.toString()),
		padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
		alignment: Alignment.center,
		color: color,
		child: Row(
		  crossAxisAlignment: CrossAxisAlignment.center,
		  children: [
			Expanded(
			  child: RichText(
				text: TextSpan(
				  children: [
					const WidgetSpan(child: Icon(Icons.warning, size: 16)),
					TextSpan(
					  text: ' $severity: ',
					  style: RoastAppTheme.materialTheme.textTheme.labelMedium,
					),
					TextSpan(
					  text: alert.message,
					  style: RoastAppTheme.materialTheme.textTheme.bodySmall,
					),
				  ],
				),
			  ),
			),
			SizedBox(
			  height: 16,
			  width: 16,
			  child: ElevatedButton(
				style: RoastAppTheme.tinyButtonTheme.style,
				onPressed: () {
				  setState(() {
					dismissed[alert.severity]!.add(alert.kind);
					_refreshAlerts();
				  });
				},
				child: const Icon(Icons.cancel, size: 12),
			  ),
			),
		  ],
		),
	  ),
	);
  }
}
