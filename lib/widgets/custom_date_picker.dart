part of 'widgets.dart';

class CustomDatePicker extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String errorValidation;
  final Color hintColor;
  final Color iconColor;
  final Function onTap;

  CustomDatePicker({this.labelText, this.hintText, this.errorValidation, this.hintColor, this.iconColor, this.onTap});

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
        Material(
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            decoration: BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: defaultWidth(context),
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12.5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hintText,
                      style: semiBlackFont.copyWith(
                        fontSize: 15,
                        color: hintColor,
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.solidCalendar,
                      color: iconColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}