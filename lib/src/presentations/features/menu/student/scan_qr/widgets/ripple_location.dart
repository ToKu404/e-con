import 'package:e_con/core/constants/color_const.dart';
import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  final double size;
  const RippleAnimation({super.key, required this.size});

  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.size;
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
      builder: (context, child) {
        return SizedBox(
          height: radius + (5 * 3),
          width: radius + (5 * 3),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: radius,
                height: radius,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.success,
                ),
              ),
              _buildContainer(radius + (5 * 1) * _controller.value),
              _buildContainer(radius + (5 * 2) * _controller.value),
              _buildContainer(radius + (5 * 3) * _controller.value),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Palette.success.withOpacity(1 - _controller.value),
      ),
    );
  }
}
