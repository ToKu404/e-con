import 'package:e_con/econ.dart';
import 'package:e_con/injection.dart' as di;
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const EconApp());
}
