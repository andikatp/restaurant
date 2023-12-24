import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  NavigatorState get navigator => Navigator.of(this);
  ModalRoute<dynamic>? get modalRoute => ModalRoute.of(this);
}
