extension DateTimeExtension on DateTime {
  String toPath() => "$year-$month-$day";
}

extension StringExtension on String {
  String removeZero() => replaceFirst(RegExp(r"0+$|\.0+$"), "");
}
