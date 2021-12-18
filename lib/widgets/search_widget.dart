part of 'widget.dart';

class SearchBoxField extends StatelessWidget {
  final TextEditingController? con;
  final String placeholder;
  final Function(String) onChanged;

  SearchBoxField({
    this.con,
    required this.placeholder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: con,
      style: fontTheme.bodyText2?.copyWith(
        color: darkGreyColor,
        fontSize: 13,
        // decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: fontTheme.bodyText2?.copyWith(
          color: lightGreyColor,
          fontSize: 13,
        ),
        contentPadding: EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: darkGreyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: lightGreyColor),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: lightGreyColor,
          size: 14,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
