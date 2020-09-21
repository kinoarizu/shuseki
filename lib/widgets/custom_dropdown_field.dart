part of 'widgets.dart';

// ignore: must_be_immutable
class CustomDropdownField extends StatelessWidget {
  final String errorValidation;
  final Function(String) onChanged;

  CustomDropdownField({this.errorValidation, this.onChanged});

  List<String> permits = ["Sakit", "Izin", "Alfa"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Jenis Izin",
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
        DropdownButtonFormField(
          hint: Text(
            "Pilih Jenis Izin",
            style: semiGreyFont.copyWith(
              fontSize: 15,
              color: Color(0xFFC6C6C6),
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: greyColor,
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
          ),
          items: permits.map((String permit) {
            return DropdownMenuItem(
              child: Text(
                permit,
                style: semiBlackFont.copyWith(fontSize: 15),
              ),
              value: permit,
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}