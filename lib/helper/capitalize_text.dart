extension StringExtension on String {
  String capitalize() {
    if (this.isNotEmpty) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    } else {
      return this;
    }
  }
}
