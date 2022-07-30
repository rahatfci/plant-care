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

String? profileNameValidator(String? name) {
  if (name!.length >= 30) {
    return "Name is too long";
  }
  return null;
}

String? carouselTitleValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the title";
  }
  return null;
}

String? carouselDescriptionValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the description";
  }
  return null;
}

String? carouselLinkValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the link";
  }
  return null;
}

String? categoryNameValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the name";
  } else if (value.length > 15) {
    return "Category name must be less than 15 character";
  }
  return null;
}

String? productNameValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the name";
  } else if (value.length > 30) {
    return "Product name must be less than 15 character";
  }
  return null;
}

String? productDescriptionValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the description";
  }
  return null;
}

String? productQuantityValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the quantity";
  }
  return null;
}

String? productCategoryValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the category name";
  } else if (value.length > 15) {
    return "Product name must be less than 15 character";
  }
  return null;
}

String? productDiscountValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the amount";
  }
  return null;
}

String? productPriceValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the amount";
  }
  return null;
}

String? phoneNumberValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter the phone no";
  }
  return null;
}

String? noValidation(String? value) {
  return null;
}
