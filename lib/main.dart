import 'package:e_con/econ.dart';
import 'package:e_con/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const EconApp()));
}
