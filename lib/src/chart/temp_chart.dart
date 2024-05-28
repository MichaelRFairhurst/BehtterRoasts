import 'dart:math';
import 'dart:ui';
import 'package:behmor_roast/src/chart/widgets/legend.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TempChart extends ConsumerStatefulWidget {
  const TempChart({
    required this.logs,
    required this.copyLogs,
    required this.isLive,
    super.key,
  });

  final List<RoastLog> logs;
  final List<RoastLog>? copyLogs;
  final bool isLive;

  @override
  TempChartState createState() => TempChartState();
}

class ChartListenable extends ChangeNotifier {
  Duration _timeRangeEnd = Duration.zero;

  Duration _elapsed = Duration.zero;

  Projection _projection = const Projection(
    roastTime: null,
    timeRemaining: null,
    timeToOverheat: null,
    currentTemp: null,
    copyRoastTempDiff: null,
    temp30s: null,
    temp60s: null,
  );

  DrawableRoot? _dryEndSvg;
  DrawableRoot? _firstCrackSvg;
  DrawableRoot? _secondCrackSvg;

  Duration get timeRangeEnd => _timeRangeEnd;

  set timeRangeEnd(Duration duration) {
    _timeRangeEnd = duration;
    notifyListeners();
  }

  Duration get elapsed => _elapsed;

  set elapsed(Duration duration) {
    _elapsed = duration;
    notifyListeners();
  }

  Projection get projection => _projection;

  set projection(Projection val) {
    _projection = val;
    notifyListeners();
  }

  DrawableRoot? get dryEndSvg => _dryEndSvg;

  set dryEndSvg(DrawableRoot? svg) {
    _dryEndSvg = svg;
    notifyListeners();
  }

  DrawableRoot? get firstCrackSvg => _firstCrackSvg;

  set firstCrackSvg(DrawableRoot? svg) {
    _firstCrackSvg = svg;
    notifyListeners();
  }

  DrawableRoot? get secondCrackSvg => _secondCrackSvg;

  set secondCrackSvg(DrawableRoot? svg) {
    _secondCrackSvg = svg;
    notifyListeners();
  }
}

class TempChartState extends ConsumerState<TempChart>
    with TickerProviderStateMixin {
  //late final AnimationController controller;
  final elapsed = ChartListenable();
  late final Ticker ticker;
  late final TimerService timerService;

  @override
  void initState() {
    super.initState();
    if (widget.isLive) {
      ticker = createTicker(_tick)..start();
      timerService = ref.read(roastTimerProvider);
      //controller = AnimationController(
      //  vsync: this,
      //);
    } else {
      elapsed.timeRangeEnd = widget.logs.last.time;
    }

    loadSvg((d) => elapsed.dryEndSvg = d, 'images/dry.svg');
    loadSvg((d) => elapsed.firstCrackSvg = d, 'images/crack.svg');
    loadSvg((d) => elapsed.secondCrackSvg = d, 'images/2nd_crack.svg');
  }

  @override
  void dispose() {
    elapsed.dispose();
    if (widget.isLive) {
      ticker.dispose();
    }
    super.dispose();
  }

  void _tick(Duration duration) {
    final newElapsed = timerService.elapsed() ?? Duration.zero;
    if (newElapsed < const Duration(minutes: 1)) {
      elapsed.timeRangeEnd = const Duration(minutes: 2);
      elapsed.elapsed = newElapsed;
    } else {
      elapsed.timeRangeEnd = newElapsed + const Duration(minutes: 1);
      elapsed.elapsed = newElapsed;
    }
  }

  void loadSvg(void Function(DrawableRoot?) setter, String path) async {
    setter(await svg.fromSvgString(
        await DefaultAssetBundle.of(context).loadString(path), path));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Projection>(projectionProvider, (old, newState) {
      elapsed.projection = newState;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomPaint(
          painter: TempChartPainter(
            elapsed: elapsed,
            logs: widget.logs,
            copyLogs: widget.copyLogs,
          ),
          child: const SizedBox(height: 250, width: double.infinity),
        ),
        Legend(
          items: [
            LegendItem(
              color: RoastAppTheme.errorColor.withOpacity(0.2),
              colorBorder: const BorderSide(
                color: RoastAppTheme.errorColor,
                width: 2.0,
              ),
              text: 'Roast Temperature',
            ),
            LegendItem(
              color: RoastAppTheme.cremaDark.withOpacity(0.2),
              colorBorder: const BorderSide(
                color: RoastAppTheme.cremaDark,
                width: 2.0,
              ),
              text: 'Target Temperature',
            ),
            LegendItem.custom(
              colorWidget: Stack(
                children: const [
                  SizedBox(width: 8, height: 8),
                  Positioned(
                    left: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: RoastAppTheme.errorColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: SizedBox(width: 4, height: 8),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: RoastAppTheme.indigo,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: SizedBox(width: 4, height: 8),
                    ),
                  ),
                ],
              ),
              textWidget: const Text('Rate of rise'),
            ),
          ],
        ),
      ],
    );
  }
}

class TempChartPainter extends CustomPainter {
  TempChartPainter({
    required this.elapsed,
    required this.logs,
    required this.copyLogs,
  }) : super(repaint: elapsed);

  final ChartListenable elapsed;
  final List<RoastLog> logs;
  final List<RoastLog>? copyLogs;
  final tempRange = 335.0;
  final padding = const EdgeInsets.fromLTRB(48, 0, 32, 32);

  Duration get timeRange => elapsed.timeRangeEnd;

  @override
  void paint(Canvas canvas, Size size) {
    final graphicRegion = padding.deflateRect(const Offset(0, 0) & size);
    canvas.drawPath(
        buildYGuidesPath(graphicRegion),
        Paint()
          ..color = RoastAppTheme.crema
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);

    drawYLabels(canvas, graphicRegion);
    drawXLabels(canvas, graphicRegion);
    drawPhaseTicks(canvas, graphicRegion);

    final tempLinePath = buildTempLinePath(graphicRegion);

    drawFirstCrackRange(canvas, graphicRegion, tempLinePath);
    drawRor(canvas, graphicRegion);

    if (copyLogs != null) {
      final copyLinePath =
          buildLinePath(copyLogs!, graphicRegion, (log) => log.temp, tempRange);
      drawLineAreaGradient(
          canvas, copyLinePath, graphicRegion, RoastAppTheme.cremaDark,
          clip: true);
    }

    drawLineAreaGradient(
        canvas, tempLinePath, graphicRegion, RoastAppTheme.errorColor,
        extraOffset: projectionPoint(graphicRegion));

    final projectionPath = buildProjectionPath(graphicRegion);

    canvas.drawPath(
        projectionPath,
        Paint()
          ..color = RoastAppTheme.errorColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  Path buildYGuidesPath(Rect region) {
    final tempScale = region.height / tempRange;

    final path = Path();
    for (int i = 0; i < tempRange; i += 100) {
      final y = region.bottom - i * tempScale;
      path.moveTo(region.left, y);
      path.lineTo(region.right, y);
    }

    return path;
  }

  void drawYLabels(Canvas canvas, Rect graphicRegion) {
    final tempScale = graphicRegion.height / tempRange;

    for (int i = 0; i < tempRange; i += 100) {
      final y = graphicRegion.bottom - i * tempScale;
      final textPainter = TextPainter(
        text: TextSpan(
          text: '$i°F',
          style: RoastAppTheme.materialTheme.textTheme.caption,
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(graphicRegion.left - textPainter.width,
              y - textPainter.height / 2));
    }
  }

  void drawXLabels(Canvas canvas, Rect graphicRegion) {
    final timeScale = graphicRegion.width / timeRange.inMilliseconds;

    // Generate 8 time labels of 15, 30, 60sec, 120sec, etc
    // Solve for n in 15sec * 2^n * 8 = timeRange
    // 2^n = timeRange / 8 / 15sec
    // n = log_2(timeRange / 8 / 15sec)
    final timeStep = const Duration(seconds: 15) *
        pow(2, (log(timeRange.inSeconds / 15.0 / 8) / ln2).ceil());

    for (Duration d = Duration.zero; d < timeRange; d += timeStep) {
      final x = d.inMilliseconds * timeScale;
      final textPainter = TextPainter(
        text: TextSpan(
          text:
              '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, "0")}',
          style: RoastAppTheme.materialTheme.textTheme.caption,
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(graphicRegion.left + x - textPainter.width / 2,
              graphicRegion.bottom));
    }
  }

  void drawRor(Canvas canvas, Rect graphicRegion) {
    final rorPositiveLinePath =
        buildLinePath(logs, graphicRegion, (log) => log.rateOfRise, tempRange);

    final rorNegativeLinePath = buildLinePath(logs, graphicRegion,
        (log) => log.rateOfRise == null ? null : -log.rateOfRise!, tempRange);

    canvas.drawPath(
        completeArea(rorPositiveLinePath, graphicRegion, clip: true),
        Paint()
          ..shader = LinearGradient(
            colors: [
              RoastAppTheme.errorColor,
              RoastAppTheme.errorColor.withOpacity(0.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(rorPositiveLinePath.getBounds())
          ..style = PaintingStyle.fill);
    canvas.drawPath(
        completeArea(rorNegativeLinePath, graphicRegion, clip: true),
        Paint()
          ..shader = LinearGradient(
            colors: [
              RoastAppTheme.indigo,
              RoastAppTheme.indigo.withOpacity(0.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(rorPositiveLinePath.getBounds())
          ..style = PaintingStyle.fill);
  }

  void drawPhaseTicks(Canvas canvas, Rect graphicRegion) {
    final timeScale = graphicRegion.width / timeRange.inMilliseconds;

    for (final log in logs) {
      final phase = log.phase;
      if (phase == null) {
        continue;
      }
      final x = graphicRegion.left + log.time.inMilliseconds * timeScale;
      final paint = Paint()..color = RoastAppTheme.metal;
      DrawableRoot? svg;
      switch (phase) {
		case RoastPhase.preheat:
        case RoastPhase.firstCrackStart:
        case RoastPhase.firstCrackEnd:
          return;

        case RoastPhase.secondCrackStart:
          svg = elapsed.secondCrackSvg;
          break;
        case RoastPhase.dryEnd:
          svg = elapsed.dryEndSvg;
          break;
        default:
      }

      if (svg != null) {
        canvas.save();
        canvas.translate(
            x - 8, graphicRegion.top + graphicRegion.height / 2 - 8);
        canvas.drawPicture(svg.toPicture(
            size: const Size(16, 16),
            colorFilter: const ColorFilter.mode(
                RoastAppTheme.capuccinoLightest, BlendMode.srcIn)));
        canvas.restore();

        canvas.drawLine(
            Offset(x, graphicRegion.bottom - graphicRegion.height / 2 + 16),
            Offset(x, graphicRegion.bottom),
            paint);
        canvas.drawLine(
            Offset(x, graphicRegion.top + graphicRegion.height / 2 - 16),
            Offset(x, graphicRegion.top),
            paint);
      } else {
        canvas.drawLine(Offset(x, graphicRegion.top),
            Offset(x, graphicRegion.bottom), paint);
      }
    }
  }

  void drawFirstCrackRange(
      Canvas canvas, Rect graphicRegion, Path tempLinePath) {
    final timeScale = graphicRegion.width / timeRange.inMilliseconds;

    final start =
        logs.firstWhereOrNull((log) => log.phase == RoastPhase.firstCrackStart);
    final end =
        logs.firstWhereOrNull((log) => log.phase == RoastPhase.firstCrackEnd);
    if (start == null) {
      return;
    }

    final Duration endTime;
    if (end != null && end.time != start.time) {
      endTime = end.time;
    } else {
      endTime = elapsed.elapsed;
    }

    final xMin = graphicRegion.left + start.time.inMilliseconds * timeScale;
    final xMax = graphicRegion.left + endTime.inMilliseconds * timeScale;
    final svg = elapsed.firstCrackSvg;

    final tempPathPlus = Path()..addPath(tempLinePath, const Offset(0, 0));
    final projection = projectionPoint(graphicRegion);
    if (projection != null) {
      tempPathPlus.lineTo(projection.dx, projection.dy);
    }

    final tempArea = completeArea(tempPathPlus, graphicRegion, clip: false);
    final firstCrackArea = Path.combine(
      PathOperation.intersect,
      tempArea,
      Path()
        ..addRect(
            Rect.fromLTRB(xMin, graphicRegion.top, xMax, graphicRegion.bottom)),
    );

    canvas.drawPath(
        firstCrackArea, Paint()..color = RoastAppTheme.metal.withOpacity(0.15));

    if (svg == null) {
      return;
    }

    canvas.save();
    canvas.translate((xMin + xMax) / 2 - 8,
        graphicRegion.top + graphicRegion.height / 2 - 8);
    canvas.drawPicture(svg.toPicture(
        size: const Size(16, 16),
        colorFilter: const ColorFilter.mode(
            RoastAppTheme.capuccinoLightest, BlendMode.srcIn)));
    canvas.restore();
  }

  void drawLineAreaGradient(Canvas canvas, Path path, Rect region, Color color,
      {bool clip = false, Offset? extraOffset}) {
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);

    final areaBasePath;
    if (extraOffset != null) {
      areaBasePath = Path()
        ..addPath(
          path,
          const Offset(0, 0),
        )
        ..lineTo(extraOffset.dx, extraOffset.dy);
    } else {
      areaBasePath = path;
    }

    canvas.drawPath(
        completeArea(areaBasePath, region, clip: clip),
        Paint()
          ..shader = LinearGradient(
            colors: [
              color.withOpacity(0.2),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(region)
          ..style = PaintingStyle.fill);
  }

  Path buildTempLinePath(Rect region) {
    return buildLinePath(logs, region, (log) => log.temp, tempRange);
  }

  Offset? projectionPoint(Rect region) {
    if (elapsed.projection.currentTemp == null) {
      return null;
    }

    final timeScale = region.width / timeRange.inMilliseconds;
    final tempScale = region.height / tempRange;
    final endX = elapsed.elapsed.inMilliseconds * timeScale;
    final endY = elapsed.projection.currentTemp! * tempScale;
    return Offset(region.left + endX, region.bottom - endY);
  }

  Path buildProjectionPath(Rect region) {
    final endPoint = projectionPoint(region);
    if (endPoint == null) {
      return Path();
    }

    final timeScale = region.width / timeRange.inMilliseconds;
    final tempScale = region.height / tempRange;
    final lastLog = logs.where((l) => l.temp != null).last;
    final startX = lastLog.time.inMilliseconds * timeScale;
    final startY = lastLog.temp! * tempScale;
    return dottedLine(region.left + startX, region.bottom - startY, endPoint.dx,
        endPoint.dy, 2);
  }

  Path buildLinePath(List<RoastLog> logs, Rect region,
      num? Function(RoastLog) attribute, double attrRange) {
    final attrScale = region.height / attrRange;
    final timeScale = region.width / timeRange.inMilliseconds;

    final slopes = <double>[];
    final offsets = <Offset>[];
    double? xPrev;
    double? yPrev;
    for (final log in logs) {
      final attr = attribute(log);
      if (attr == null || log.time.isNegative) {
        continue;
      }

      final x = log.time.inMilliseconds * timeScale;
      final y = attr * attrScale;

      if (xPrev != null && yPrev != null) {
        final slope = (y - yPrev) / (x - xPrev);
        slopes.add(slope);
        if (timeRange.inMilliseconds < log.time.inMilliseconds) {
          offsets.add(
              Offset(region.width, yPrev + slope * (region.width - xPrev)));
          break;
        }
      }

      offsets.add(Offset(x, y));

      xPrev = x;
      yPrev = y;
    }

    if (slopes.isNotEmpty) {
      slopes.add(slopes.last);
    }

    final path = Path();
    for (int i = 0; i < offsets.length; ++i) {
      final offset = offsets[i];
      if (i == 0) {
        path.moveTo(region.left + offset.dx, region.bottom - offset.dy);
      } else {
        final offsetPrev = offsets[i - 1];
        final offsetDiff = offset - offsetPrev;
        final slopePrev = slopes[i - 1];
        final slopeCur = slopes[i];
        path.cubicTo(
          region.left + offsetPrev.dx + offsetDiff.dx / 2,
          region.bottom - offsetPrev.dy - slopePrev * offsetDiff.dx / 2,
          region.left + offset.dx - offsetDiff.dx / 2,
          region.bottom - offset.dy + slopeCur * offsetDiff.dx / 2,
          region.left + offset.dx,
          region.bottom - offset.dy,
        );
      }
    }

    return path;
  }

  Path completeArea(Path linePath, Rect region, {bool clip = false}) {
    final bounds = linePath.getBounds();
    final completed = Path()
      ..addPath(linePath, const Offset(0, 0))
      ..lineTo(bounds.right, region.bottom)
      ..lineTo(bounds.left, region.bottom)
      ..lineTo(bounds.left, bounds.bottom);

    if (!clip) {
      return completed;
    }

    return Path.combine(
      PathOperation.intersect,
      completed,
      Path()..addRect(region),
    );
  }

  Path dottedLine(double x1, double y1, double x2, double y2, double dotWidth) {
    final slope = (y2 - y1) / (x2 - x1);
    final hypotenuse = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
    final lengthFactor = (x2 - x1) / hypotenuse;

    final deltaX = dotWidth * lengthFactor;
    final deltaY = deltaX * slope;

    final path = Path();
    var dash = false;
    for (double x = x1, y = y1;
        x < x2 + deltaX;
        x += deltaX, y += deltaY, dash = !dash) {
      if (dash) {
        if (x > x2) {
          path.lineTo(x2, y2);
        } else {
          path.lineTo(x, y);
        }
      } else {
        path.moveTo(x, y);
      }
    }

    return path;
  }

  @override
  bool shouldRepaint(TempChartPainter oldDelegate) => true;
}
