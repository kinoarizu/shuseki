part of 'provider.dart';

class ValidationProvider extends ChangeNotifier {
  String _errorNIDK;
  String _errorName;
  String _errorEmail;
  String _errorPassword;
  String _errorPasswordConfirmation;

  String get errorNIDK => _errorNIDK;
  String get errorName => _errorName;
  String get errorEmail => _errorEmail;
  String get errorPassword => _errorPassword;
  String get errorPasswordConfirmation => _errorPasswordConfirmation;

  void changeNIDK(String value) {
    if (value.length == 10) {
      _errorNIDK = "";
    } 
    else if (value.length == 0) {
      _errorNIDK = "NIDK Harus Diisikan";
    } 
    else {
      _errorNIDK = "NIDK Harus 10 Karakter";
    }

    notifyListeners();
  }

  void changeName(String value) {
    if (value.length == 0) {
      _errorName = "Nama Harus Diisikan";
    } 
    else {
      _errorName = "";
    }

    notifyListeners();
  }

  void changeEmail(String value) {
    if (value.length == 0) {
      _errorEmail = "Email Harus Diisikan";
    }
    else if (EmailValidator.validate(value) == false) {
      _errorEmail = "Email Harus Valid";
    }
    else {
      _errorEmail = "";
    }

    notifyListeners();
  }

  void changePassword(String value) {
    if (value.length == 0) {
      _errorPassword = "Password Harus Diisikan";
    }
    else if (value.length < 6) {
      _errorPassword = "Password Minimal 6 karakter";
    }
    else {
      _errorPassword = "";
    }

    notifyListeners();
  }

  void changePasswordConfirmation(String value, String password) {
    if (value.length == 0) {
      _errorPasswordConfirmation = "Password Harus Diisikan";
    }
    else if (value != password) {
      _errorPasswordConfirmation = "Konfirmasi Tidak Sama";
    }
    else {
      _errorPasswordConfirmation = "";
    }

    notifyListeners();
  }

  bool isAllValidate() {
    if (_errorNIDK == "" && _errorName == "" && _errorEmail == "" && _errorPassword == "" && _errorPasswordConfirmation == "") {
      return true;
    }
    else {
      return false;
    }
  }

  void resetChange() {
    _errorNIDK = null;
    _errorName = null;
    _errorEmail = null;
    _errorPassword = null;
    _errorPasswordConfirmation = null;

    notifyListeners();
  }
}