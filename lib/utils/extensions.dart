extension IndianDateFormat on DateTime {
  // Convert a DateTime into "dd-MM-yyyy" format
  String toIndianFormat() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();

    return "$day-$month-$year";
  }

  // Parse "dd-MM-yyyy" into DateTime
  static DateTime toDate(String date) {
    final parts = date.split('-');
    if (parts.length == 3) {
      final day = int.tryParse(parts[0]) ?? 1;
      final month = int.tryParse(parts[1]) ?? 1;
      final year = int.tryParse(parts[2]) ?? 1970;
      return DateTime(year, month, day);
    }
    throw FormatException("Invalid date format, expected dd-MM-yyyy");
  }
}
