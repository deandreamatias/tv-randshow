import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:unicons/unicons.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    this.distance = 100,
    this.startAngle = 0,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final int startAngle;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      _open ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _CloseFabButton(onTap: _toggle),
          ...widget.children.map((e) {
            final count = widget.children.length;
            final index = widget.children.indexOf(e);
            final step = 90.0 / (count - 1);
            final angleInDegrees = step * index + widget.startAngle;

            return _ExpandingActionButton(
              directionInDegrees: angleInDegrees,
              maxDistance: widget.distance,
              progress: _expandAnimation,
              child: e,
            );
          }),
          _OpenFabButton(onTap: _toggle, isOpen: _open),
        ],
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );

        const position = 4;

        return Positioned(
          right: position + offset.dx,
          bottom: position + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class _OpenFabButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isOpen;
  const _OpenFabButton({
    this.isOpen = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final diagonalValue = isOpen ? 0.7 : 1.0;

    return IgnorePointer(
      ignoring: isOpen,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          diagonalValue,
          // Make sense use the same argument here.
          // ignore: no-equal-arguments
          diagonalValue,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: isOpen ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: onTap,
            child: const Icon(CustomIcons.diceMultiple),
          ),
        ),
      ),
    );
  }
}

class _CloseFabButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseFabButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).colorScheme.inversePrimary,
          elevation: Styles.xsmall,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(Styles.small),
              child: Icon(
                UniconsLine.multiply,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
