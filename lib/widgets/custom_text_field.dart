part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget suffixIcon;
  final String errorValidation;
  final int maxLines;

  CustomTextField({
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.errorValidation,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: semiBlackFont.copyWith(fontSize: 16),
            ),
            if (errorValidation != null) Text(
              errorValidation,
              style: semiBlackFont.copyWith(
                color: maroonColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          style: semiBlackFont.copyWith(fontSize: 15),
          maxLines: (maxLines != null) ? maxLines : 1,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: greyColor,
            hintText: hintText,
            hintStyle: semiGreyFont.copyWith(
              fontSize: 15,
              color: Color(0xFFC6C6C6),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12.5,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                style: BorderStyle.none,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}