class Converters {
  static DateTime? fromJsonDate(String? date) {
    return date == null || date.isEmpty ? null : DateTime.parse(date);
  }
}
