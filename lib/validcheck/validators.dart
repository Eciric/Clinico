
String validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{9,9}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
        return 'Type phone number';
  }
  else if (!regExp.hasMatch(value)) {
        return 'Please type number with 9 digits';
  }
  return null;
}  

String validatePeselNumber(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{11,11}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
        return 'Type Pesel number';
  }
  else if (!regExp.hasMatch(value)) {
        return 'Please type number with 11 digits';
  }
  return null;
} 