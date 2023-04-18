import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..stepDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';
  // TODO
  return GherkinRunner().execute(config);
}
