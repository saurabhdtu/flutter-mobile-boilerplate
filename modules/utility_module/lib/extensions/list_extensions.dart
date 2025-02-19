extension ListUtils on List? {
  bool isEmptyOrNull() => this == null || this?.isEmpty == true;
}