import 'package:flutter_driver/driver_extension.dart';
import 'package:linkpedia/main.dart' as app;
import 'package:flutter/widgets.dart';

void main() {
  enableFlutterDriverExtension();

  runApp(const app.Linkpedia());
}
