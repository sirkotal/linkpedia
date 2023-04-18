import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';

class OnTheLoginScreen extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final loginScreenFinder = driver.find.byValueKey('login_screen');
    await expectLater(await world.driver!.waitFor(loginScreenFinder), isTrue);
  }

  @override
  RegExp get pattern => RegExp(r'the user is on the "Login" page');
}
