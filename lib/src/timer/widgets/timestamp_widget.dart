import 'package:flutter/widgets.dart';

class TimestampWidget extends StatelessWidget {
  const TimestampWidget(this.time, {
    this.twitterFormat = false,
	super.key,
  });

  const TimestampWidget.twitter(this.time, {
	super.key,
  }) : twitterFormat = true;

  final Duration time;
  final bool twitterFormat;

  @override
  Widget build(BuildContext context) => Text(formattedTime());

  String formattedTime() {
    final minutes = time.abs().inMinutes;
    final seconds = formatSegment(time.abs().inSeconds % 60);
	final negative = time.isNegative ? '-' : '';
    return twitterFormat
	  ? '$negative${minutes}m${seconds}s' : '$negative$minutes:$seconds';
  }

  String formatSegment(num segment) {
	assert(segment >= 0);
    final flat = segment.floor();
    if (flat < 10) {
      return '0$flat';
    } else {
      return flat.toString();
    }
  }

}
