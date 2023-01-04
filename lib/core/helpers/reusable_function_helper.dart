import 'package:intl/intl.dart';

class ReusableFuntionHelper {
  static String datetimeToString(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(date);
  }

  static DateTime stringToDateTime(String date) {
    return DateFormat("EEEE, dd MMMM yyyy", "id_ID").parse(date);
  }
}
