import 'package:flutter/material.dart';

class StyleColor {
  static const Color PRIMARY = Color(0xFFE40505);
  static const Color SECONDARY = Color(0xFF002984);
  static const Color TEXT_HIGH = Color(0xDE000000);
  static const Color TEXT_MEDIUM = Color(0x99000000);
  static const Color TEXT_DISABLE = Color(0x61000000);
  static const Color WHITE = Color(0xFFFFFFFF);
}

class StyleText {
  static const TextStyle MESSAGES =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static const TextStyle TITLE =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const TextStyle INFO_BOX_NUMBER = TextStyle(
      color: StyleColor.WHITE, fontSize: 26, fontWeight: FontWeight.w700);
  static const TextStyle INFO_BOX_TITLE =
      TextStyle(color: StyleColor.WHITE, fontSize: 16);
  static const TextStyle DESCRIPTION = TextStyle(
      color: StyleColor.WHITE, fontSize: 12, fontWeight: FontWeight.w300);
  static const TextStyle NAME =
      TextStyle(color: StyleColor.WHITE, fontWeight: FontWeight.w600);
  static const TextStyle PRIMARY = TextStyle(color: StyleColor.PRIMARY);
  static const TextStyle WHITE = TextStyle(color: StyleColor.WHITE);
}

const BorderRadiusGeometry BORDER_RADIUS =
    BorderRadius.all(Radius.circular(8.0));
const EdgeInsets SMALL_INSESTS = EdgeInsets.all(8.0);
const EdgeInsets DEFAULT_INSESTS = EdgeInsets.all(16.0);
