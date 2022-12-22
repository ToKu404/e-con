import 'package:e_con/src/data/models/cpl_lecturer/time_data.dart';
import 'package:intl/intl.dart';

class ReusableFuntionHelper {
  static String datetimeGenerator(DateTime date, TimeData start, TimeData end) {
    final dayMapping = {
      'Sun': 'Minggu',
      'Mon': 'Senin',
      'Tue': 'Selasa',
      'Wed': 'Rabu',
      'Thu': 'Kamis',
      'Fri': 'Jum\'at',
      'Sat': 'Sabtu'
    };

    String startTime =
        '${start.hour.toString().padLeft(2, "0")}:${start.minute.toString().padLeft(2, "0")}';
    String endTime =
        '${end.hour.toString().padLeft(2, "0")}:${end.minute.toString().padLeft(2, "0")}';
    String dayName = dayMapping[DateFormat('EEE').format(date)]!;

    return '$dayName $startTime - $endTime';
  }
}
