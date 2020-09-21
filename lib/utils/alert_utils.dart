part of 'utils.dart';

void showAlert(BuildContext context, {Widget alert}) {
  showDialog(
    context: context,
    builder: (context) => alert,
  );
}