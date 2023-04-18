import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/on_login_screen.dart';
import 'dart:async';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..defaultTimeout = const Duration(seconds: 30)
    ..features = [Glob(r"test_driver/features/auth.feature")]
    ..reporters = [ProgressReporter()]
    ..stepDefinitions = [
      CheckGivenWidgets(),
      FillFormField(),
      ClickLoginButton(),
      CheckIfHomePageIsPresent()
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';
  return GherkinRunner().execute(config);
}
