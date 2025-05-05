enum SectionType {
  live_doctors,
  popular_doctors,
  featured_doctors,
  unknown;

  factory SectionType.fromString(String value) {
    return SectionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => SectionType.unknown,
    );
  }
}
