import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double durationScale = 1.5;
int _kIndeterminateLinearDuration = (2400 * durationScale).toInt();

class Loading extends ProgressIndicator {
  /// Creates a linear progress indicator.
  ///
  /// {@macro flutter.material.progressIndicator.parameters}
  Loading(
      {Key? key,
      double? value,
      Color? backgroundColor = Colors.transparent,
      Animation<Color>? valueColor,
      this.minHeight,
      this.direction = Axis.vertical,
      String? semanticsLabel,
      String? semanticsValue})
      : assert(minHeight == null || minHeight > 0),
        super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor ??
              AlwaysStoppedAnimation(Colors.grey.withOpacity(0.15)),
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  /// The minimum height of the line used to draw the indicator.
  ///
  /// This defaults to 4dp.
  final double? minHeight;
  final Axis direction;
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    );
    if (widget.value == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(Loading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, double animationValue,
      TextDirection textDirection) {
    return widget._buildSemanticsWrapper(
      context: context,
      child: Container(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: widget.minHeight ?? double.infinity,
        ),
        child: CustomPaint(
          painter: _LoadingPainter(
            backgroundColor: widget._getBackgroundColor(context),
            valueColor: widget._getValueColor(context),
            value: widget.value,
            // may be null
            animationValue: animationValue,
            // ignored if widget.value is not null
            textDirection: textDirection,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);

    if (widget.value != null) {
      return RotatedBox(
        quarterTurns: widget.direction == Axis.vertical ? 1 : 0,
        child: _buildIndicator(context, _controller.value, textDirection),
      );
    }

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return RotatedBox(
          quarterTurns: widget.direction == Axis.vertical ? 1 : 0,
          child: _buildIndicator(context, _controller.value, textDirection),
        );
      },
    );
  }
}

class _LoadingPainter extends CustomPainter {
  const _LoadingPainter({
    this.backgroundColor,
    this.valueColor,
    this.value,
    this.animationValue,
    required this.textDirection,
  });

  final Color? backgroundColor;
  final Color? valueColor;
  final double? value;
  final double? animationValue;
  final TextDirection textDirection;

  // The indeterminate progress animation displays two lines whose leading (head)
  // and trailing (tail) endpoints are defined by the following four curves.
  static Curve line1Head = Interval(
    0.0,
    750.0 * durationScale / _kIndeterminateLinearDuration,
    curve: const Cubic(0.2, 0.0, 0.8, 1.0),
  );
  static Curve line1Tail = Interval(
    333.0 * durationScale / _kIndeterminateLinearDuration,
    (333.0 + 750.0) * durationScale / _kIndeterminateLinearDuration,
    curve: const Cubic(0.4, 0.0, 1.0, 1.0),
  );
  static Curve line2Head = Interval(
    1000.0 * durationScale / _kIndeterminateLinearDuration,
    (1000.0 + 567.0) * durationScale / _kIndeterminateLinearDuration,
    curve: const Cubic(0.0, 0.0, 0.65, 1.0),
  );
  static Curve line2Tail = Interval(
    1267.0 * durationScale / _kIndeterminateLinearDuration,
    (1267.0 + 533.0) * durationScale / _kIndeterminateLinearDuration,
    curve: const Cubic(0.10, 0.0, 0.45, 1.0),
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor!
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, paint);

    paint.color = valueColor!;

    void drawBar(double x, double width) {
      if (width <= 0.0) return;

      late double left;
      switch (textDirection) {
        case TextDirection.rtl:
          left = size.width - width - x;
          break;
        case TextDirection.ltr:
          left = x;
          break;
      }
      canvas.drawRect(Offset(left, 0.0) & Size(width, size.height), paint);
    }

    if (value != null) {
      drawBar(0.0, value!.clamp(0.0, 1.0) * size.width);
    } else {
      final double x1 = size.width * line1Tail.transform(animationValue!);
      final double width1 =
          size.width * line1Head.transform(animationValue!) - x1;

      final double x2 = size.width * line2Tail.transform(animationValue!);
      final double width2 =
          size.width * line2Head.transform(animationValue!) - x2;

      drawBar(x1, width1);
      drawBar(x2, width2);
    }
  }

  @override
  bool shouldRepaint(_LoadingPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.animationValue != animationValue ||
        oldPainter.textDirection != textDirection;
  }
}

abstract class ProgressIndicator extends StatefulWidget {
  /// Creates a progress indicator.
  ///
  /// {@template flutter.material.progressIndicator.parameters}
  /// The [value] argument can either be null for an indeterminate
  /// progress indicator, or non-null for a determinate progress
  /// indicator.
  ///
  /// ## Accessibility
  ///
  /// The [semanticsLabel] can be used to identify the purpose of this progress
  /// bar for screen reading software. The [semanticsValue] property may be used
  /// for determinate progress indicators to indicate how much progress has been made.
  /// {@endtemplate}
  const ProgressIndicator({
    Key? key,
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
  }) : super(key: key);

  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  ///
  /// If null, this progress indicator is indeterminate, which means the
  /// indicator displays a predetermined animation that does not indicate how
  /// much actual progress is being made.
  final double? value;

  /// The progress indicator's background color.
  ///
  /// The current theme's [ThemeData.backgroundColor] by default.
  final Color? backgroundColor;

  /// The progress indicator's color as an animated value.
  ///
  /// To specify a constant color use: `AlwaysStoppedAnimation<Color>(color)`.
  ///
  /// If null, the progress indicator is rendered with the current theme's
  /// [ThemeData.colorScheme.secondary].
  final Animation<Color>? valueColor;

  /// {@template flutter.material.progressIndicator.semanticsLabel}
  /// The [Semantics.label] for this progress indicator.
  ///
  /// This value indicates the purpose of the progress bar, and will be
  /// read out by screen readers to indicate the purpose of this progress
  /// indicator.
  /// {@endtemplate}
  final String? semanticsLabel;

  /// {@template flutter.material.progressIndicator.semanticsValue}
  /// The [Semantics.value] for this progress indicator.
  ///
  /// This will be used in conjunction with the [semanticsLabel] by
  /// screen reading software to identify the widget, and is primarily
  /// intended for use with determinate progress indicators to announce
  /// how far along they are.
  ///
  /// For determinate progress indicators, this will be defaulted to [value]
  /// expressed as a percentage, i.e. `0.1` will become '10%'.
  /// {@endtemplate}
  final String? semanticsValue;

  Color _getBackgroundColor(BuildContext context) =>
      backgroundColor ?? Theme.of(context).backgroundColor;

  Color _getValueColor(BuildContext context) =>
      valueColor?.value ?? Theme.of(context).accentColor;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', value,
        showName: false, ifNull: '<indeterminate>'));
  }

  Widget _buildSemanticsWrapper({
    required BuildContext context,
    required Widget child,
  }) {
    String? expandedSemanticsValue = semanticsValue;
    if (value != null) {
      expandedSemanticsValue ??= '${(value! * 100).round()}%';
    }
    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }
}
