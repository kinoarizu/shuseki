part of 'widgets.dart';

class CustomRaisedButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Color color;
  final Color textColor;
  final Function onPressed;

  CustomRaisedButton(
    this.text, {
    this.width,
    this.height = 48,
    this.color,
    this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width == null) ? defaultWidth(context) : width,
      height: height,
      child: RaisedButton(
        color: color,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.black.withOpacity(0.4),
        visualDensity: VisualDensity.comfortable,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: semiWhiteFont.copyWith(
            fontSize: 16,
            color: textColor,
          ),
        ),
        onPressed: onPressed != null ? () {
          if (onPressed != null) {
            onPressed();
          }
        } : null,
      ),
    );
  }
}