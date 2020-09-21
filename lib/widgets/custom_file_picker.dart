part of 'widgets.dart';

class CustomFilePicker extends StatelessWidget {
  final String hintText;
  final Color hintColor;
  final Function onTap;

  CustomFilePicker({this.hintText, this.hintColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Lampirkan File",
              style: semiBlackFont.copyWith(fontSize: 16),
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
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidFile,
                      color: (hintText == "Pilih File") ? Color(0xFFC6C6C6) : darkColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      hintText,
                      style: semiBlackFont.copyWith(
                        fontSize: 15,
                        color: hintColor,
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    FaIcon(
                      (hintText == "Pilih File") ? FontAwesomeIcons.plusCircle : FontAwesomeIcons.solidWindowClose,
                      color: (hintText == "Pilih File") ? Color(0xFFC6C6C6) : darkColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          "Jenis File Yang Dibolehkan: pdf, png, jpg, docs",
          style: semiBlackFont.copyWith(
            color: Color(0xFFC6C6C6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}