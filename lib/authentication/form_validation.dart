String? nameValidator(String? name, bool signup) {
  if (signup == false) {
    return null;
  }
  if (name!.isEmpty) {
    return "Name can't be Empty";
  }
  if (name.length >= 30) {
    return "Name is too long";
  }
  return null;
}

String? emailValidator(String? email) {
  if (email!.isEmpty) {
    return "Please enter an email";
  } else if (email.length >= 30) {
    return "Email is too long";
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return "Enter a valid email";
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password!.isEmpty) {
    return "Password can't be empty";
  } else if (password.length < 6) {
    return "Password must be greater than 6 character";
  }
  return null;
}
