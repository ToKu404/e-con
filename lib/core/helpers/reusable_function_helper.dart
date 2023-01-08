import 'package:intl/intl.dart';

class ReusableFuntionHelper {
  static String datetimeToString(DateTime date, {bool isShowTime = false}) {
    return isShowTime
        ? DateFormat('HH:MM, dd MMMM yyyy', "id_ID").format(date)
        : DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(date);
  }

  static DateTime stringToDateTime(String date) {
    return DateFormat("EEEE, dd MMMM yyyy", "id_ID").parse(date);
  }
}
