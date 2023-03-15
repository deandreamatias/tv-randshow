import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/assets.dart';

class AnimationRandomLoader extends StatelessWidget {
  const AnimationRandomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlareActor(
      Assets.loading,
      animation: 'Loading',
    );
  }
}
