import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

Future<void> main() {
  final config = FlutterTestConfiguration();
  // TODO
  return GherkinRunner().execute(config);
}
