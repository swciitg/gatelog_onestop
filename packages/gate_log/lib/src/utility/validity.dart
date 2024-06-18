String? validateField(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field cannot be empty';
  }
  return null;
}
