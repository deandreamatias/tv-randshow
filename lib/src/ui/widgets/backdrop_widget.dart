import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

const _kFlingVelocity = 2.0;

class _BackdropPanel extends StatelessWidget {
  const _BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12.0,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: onVerticalDragUpdate,
        onVerticalDragEnd: onVerticalDragEnd,
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class Backdrop extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  final double frontPanelOpenHeight;
  final ValueNotifier<bool> panelVisible;

  Backdrop(
      {@required this.frontLayer,
      @required this.backLayer,
      this.frontPanelOpenHeight = 0.0,
      this.panelVisible})
      : assert(frontLayer != null),
        assert(backLayer != null);

  @override
  createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {
  final _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      // value of 0 hides the panel; value of 1 fully shows the panel
      value: (widget.panelVisible?.value ?? true) ? 1.0 : 0.0,
      vsync: this,
    );

    // Listen on the toggle value notifier if it's not null

    widget.panelVisible?.addListener(_subscribeToValueNotifier);

    // Ensure that the value notifier is updated when the panel is opened or closed
    if (widget.panelVisible != null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed)
          widget.panelVisible.value = true;
        else if (status == AnimationStatus.dismissed) widget.panelVisible.value = false;
      });
    }
  }

  void _subscribeToValueNotifier() {
    if (widget.panelVisible.value != _backdropPanelVisible) _toggleBackdropPanelVisibility();
  }

  /// Required for resubscribing when hot reload occurs
  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.panelVisible?.removeListener(_subscribeToValueNotifier);
    widget.panelVisible?.addListener(_subscribeToValueNotifier);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.panelVisible?.dispose();
    super.dispose();
  }

  bool get _backdropPanelVisible =>
      _controller.status == AnimationStatus.completed ||
      _controller.status == AnimationStatus.forward;

  void _toggleBackdropPanelVisibility() =>
      _controller.fling(velocity: _backdropPanelVisible ? -_kFlingVelocity : _kFlingVelocity);

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_controller.isAnimating) _controller.value -= details.primaryDelta / _backdropHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(_kFlingVelocity, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-_kFlingVelocity, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  Widget build(BuildContext context) {
    final panelDetailsPosition = Tween<Offset>(
      begin: Offset(0.0, 1.35),
      end: Offset(0.0, 0.30),
    ).animate(_controller.view);
    return Container(
      key: _backdropKey,
      child: Stack(
        children: <Widget>[
          widget.backLayer,
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: SlideTransition(
              position: panelDetailsPosition,
              child: _BackdropPanel(
                onTap: _toggleBackdropPanelVisibility,
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                child: widget.frontLayer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
