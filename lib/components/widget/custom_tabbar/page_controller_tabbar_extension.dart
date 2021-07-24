import 'package:flutter/widgets.dart';

extension TabbarPageControllerExtension on PageController {
  // ignore: invalid_use_of_protected_member
  double get page => positions.isEmpty ? 0 : page;

  // ignore: invalid_use_of_protected_member
  bool get isInitialized => positions.isNotEmpty;
  // ignore: invalid_use_of_protected_member
  bool get isNotInitialized => positions.isEmpty;
}
