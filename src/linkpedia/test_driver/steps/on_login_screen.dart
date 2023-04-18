import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
//import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';

class OnTheLoginScreen extends Given1WithWorld<String,FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final loginScreenFinder = find.byValueKey(input1);
    bool input1Exists = await FlutterDriverUtils.isPresent(world.driver, loginScreenFinder);
    //await expectLater(await world.driver!.waitFor(loginScreenFinder), isTrue);
    expect(input1Exists, true);
  }

  @override
  RegExp get pattern => RegExp(r"the user is on the {string} page");
}

class ClickLoginButton extends When1WithWorld<String, FlutterWorld> {
@override
Future<void> executeStep(String loginbutton) async {
  final loginfinder = find.byValueKey(loginbutton);
  await FlutterDriverUtils.tap(world.driver, loginfinder);
}
@override
RegExp get pattern => RegExp(r"presses the {string} button");
}
