import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tv_randshow/ui/shared/assets.dart';

class AnimationRandomLoader extends StatelessWidget {
  const AnimationRandomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(Assets.loading, animations: ['Loading']);
  }
}
