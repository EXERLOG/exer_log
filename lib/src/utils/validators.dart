class Validators {
  /// TODO: Need to add more validators
  static String? requiredField(String? value) {
    if (value == null || value.isEmpty) return "This field is required";
    return null;
  }
}
