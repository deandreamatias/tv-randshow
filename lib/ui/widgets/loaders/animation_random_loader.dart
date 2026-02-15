import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tv_randshow/ui/shared/assets.dart';

class AnimationRandomLoader extends StatefulWidget {
  const AnimationRandomLoader({super.key});

  @override
  State<AnimationRandomLoader> createState() => _AnimationRandomLoaderState();
}

class _AnimationRandomLoaderState extends State<AnimationRandomLoader> {
  late File file;
  Artboard? artboard;
  late SingleAnimationPainter painter;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    file = (await File.asset(Assets.loading, riveFactory: Factory.flutter))!;
    painter = SingleAnimationPainter('Loading');
    artboard = file.defaultArtboard();
    setState(() {});
  }

  @override
  void dispose() {
    painter.dispose();
    artboard?.dispose();
    file.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: artboard == null
          ? CircularProgressIndicator()
          : RiveArtboardWidget(artboard: artboard!, painter: painter),
    );
  }
}
