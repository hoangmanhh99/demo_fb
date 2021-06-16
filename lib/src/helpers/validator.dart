import 'package:validators/validators.dart' as validate;

class Validators {
  // Check email
  static bool isValidEmail(String email) {
    return email != '' && validate.isEmail(email);
  }
  static bool isValidPhone(String phone){
    return phone !=null &&
    phone != "" &&
    phone.length == 10&&
    validate.isNumeric(phone);
  }
  //check password
  static bool isPassword(String password) {
    return password != null &&
        password != '' &&
        password.length >= 6 &&
        password.length <= 15;
  }
}
