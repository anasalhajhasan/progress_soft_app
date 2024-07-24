class MainDropDownProps<T> {
  MainDropDownProps({
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.validator,
    this.isRequired,
  });
  final String labelText;
  final String hintText;
  final List<String> items;
  final String? selectedItem;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool? isRequired;
}
