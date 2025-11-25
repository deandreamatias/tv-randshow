import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';
import 'package:unicons/unicons.dart';

const int _quarterAngle = 90;
const int _midAngle = 180;
const int _divisable = 2;

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    this.distance = 100,
    this.startAngle = 0,
    this.maxAngle = _quarterAngle,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final int startAngle;
  final int maxAngle;
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
    final offsetCorrection = Offset.fromDirection(
      (widget.maxAngle + widget.startAngle) * (math.pi / _midAngle),
      widget.distance,
    );
    final height = offsetCorrection.dy.abs() * 2;
    final width = widget.distance * 1.8;

    return SafeArea(
      child: SizedBox(
        width: _open ? width : null,
        height: _open ? height : null,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            _CloseFabButton(onTap: _toggle),
            ...widget.children.map((e) {
              final count = widget.children.length;
              final index = widget.children.indexOf(e);
              final step = widget.maxAngle / (count - 1);
              final angleInDegrees = step * index + widget.startAngle;

              return _ExpandingActionButton(
                directionInDegrees: angleInDegrees,
                maxDistance: widget.distance,
                progress: _expandAnimation,
                correctionPosition: _open
                    ? offsetCorrection.dx.abs().toInt()
                    : 0,
                child: e,
              );
            }),
            _OpenFabButton(onTap: _toggle, isOpen: _open),
          ],
        ),
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
    this.correctionPosition = 0,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  final int correctionPosition;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / _midAngle),
          progress.value * maxDistance,
        );

        return Positioned(
          left: correctionPosition + offset.dx,
          bottom: offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / _divisable,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      child: FadeTransition(opacity: progress, child: child),
    );
  }
}

class _OpenFabButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isOpen;
  const _OpenFabButton({this.isOpen = false, required this.onTap});

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
            heroTag: const Key('open_fab'),
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
    return FloatingActionButton.small(
      heroTag: const Key('close_fab'),
      onPressed: onTap,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      child: const Icon(UniconsLine.multiply),
    );
  }
}
