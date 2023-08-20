import 'package:flutter/material.dart';

class ToggleIndeterminateElasticIndicator extends StatelessWidget {
  const ToggleIndeterminateElasticIndicator({
    super.key,
    this.isVisible = true,
    this.toggleDuration = const Duration(milliseconds: 600),
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeInOut,
    this.indicatorHeight = 3,
    this.color = Colors.black,
    this.capValue = 10,
    this.bounce = true,
  });

  final bool isVisible;
  final Duration toggleDuration;
  final Duration duration;
  final Curve curve;
  final double indicatorHeight;
  final Color color;
  final double capValue;
  final bool bounce;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: toggleDuration,
      transitionBuilder: (child, animation) => SizeTransition(
        sizeFactor: animation,
        child: child,
      ),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: isVisible
          ? IndeterminateElasticIndicator(
              key: const ValueKey('Progress'),
              duration: duration,
              curve: curve,
              indicatorHeight: indicatorHeight,
              color: color,
              capValue: capValue,
              bounce: bounce,
            )
          : const SizedBox.shrink(
              key: ValueKey('nil'),
            ),
    );
  }
}

class IndeterminateElasticIndicator extends StatefulWidget {
  const IndeterminateElasticIndicator({
    super.key,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeInOut,
    this.indicatorHeight = 3,
    this.color = Colors.black,
    this.capValue = 10,
    this.bounce = true,
  });

  final Duration duration;
  final Curve curve;
  final double indicatorHeight;
  final Color color;
  final double capValue;
  final bool bounce;

  @override
  State<IndeterminateElasticIndicator> createState() =>
      _IndeterminateElasticIndicatorState();
}

class _IndeterminateElasticIndicatorState
    extends State<IndeterminateElasticIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: widget.bounce);
    _animation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              final double width = constraints.maxWidth;
              final double animationValue = _animation.value;

              final double containerWidth;
              final Matrix4? transform;

              if (animationValue <= 1.0) {
                containerWidth = animationValue * width;
                transform = null;
              } else {
                containerWidth = (2.0 - animationValue) * width;
                transform = Matrix4.translationValues(
                  width, // set this to the width of the container
                  0.0,
                  0.0,
                )..scale(-1.0, 1.0);
              }

              return Container(
                width: containerWidth,
                height: widget.indicatorHeight,
                transform: transform,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.capValue)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
