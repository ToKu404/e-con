import 'package:e_con/core/dependency_injection/init.dart' as di;
import 'package:e_con/econ.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  // NotifHelper authHelper = Ge
  // authHelper.init();
  // authHelper.generateUserAppId();

  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const EconApp()));
}
