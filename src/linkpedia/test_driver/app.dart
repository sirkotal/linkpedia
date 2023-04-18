import 'package:flutter_driver/driver_extension.dart';
import 'package:linkpedia/main.dart' as app;
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:linkpedia/firebase_options.dart';

void main() async {
  enableFlutterDriverExtension();

  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const app.Linkpedia());
}
