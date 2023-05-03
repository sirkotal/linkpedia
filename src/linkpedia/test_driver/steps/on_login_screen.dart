import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckGivenWidgets extends Given3WithWorld<String, String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2, String input3) async {
    final emailfield = find.byValueKey(input1);
    final passfield = find.byValueKey(input2);
    final button = find.byValueKey(input3);
    await FlutterDriverUtils.isPresent(world.driver, emailfield);
    await FlutterDriverUtils.isPresent(world.driver, passfield);
    await FlutterDriverUtils.isPresent(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r'I have {string} and {string} and {string}');
}

class FillFormField extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2) async {
    await FlutterDriverUtils.enterText(
        world.driver, find.byValueKey(field1), field2);
  }

  @override
  RegExp get pattern => RegExp(r'I fill {string} field with {string}');
}

class ClickLoginButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String loginbutton) async {
    final loginfinder = find.byValueKey(loginbutton);
    await FlutterDriverUtils.tap(world.driver, loginfinder);
  }
  @override
  RegExp get pattern => RegExp(r'I tap the {string} button');
}

class CheckIfHomePageIsPresent extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final homefinder = find.text('Welcome to Linkpedia!');
    await FlutterDriverUtils.waitForFlutter(world.driver);
    await world.driver?.waitFor(homefinder);
    bool isPresent = await FlutterDriverUtils.isPresent(world.driver, homefinder);
    expect(isPresent, true);
  }

  @override
  RegExp get pattern => RegExp(r'I wait until the text {string} to be present');
}
