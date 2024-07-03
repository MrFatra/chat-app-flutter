import 'package:intl/intl.dart';

String formatDate(String isoDateString) {
  DateTime dateTime = DateTime.parse(isoDateString);
  String formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(dateTime);
  return formattedDate;
}
