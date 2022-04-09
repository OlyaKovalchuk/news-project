const errorWeakPassword = 'weak-password';
const errorEmailAlreadyInUse = 'email-already-exists';
const errorUidAlreadyExists = 'auth/uid-already-exists';
const errorUserNotFound = 'user-not-found';
const errorInvalidPassword = 'invalid-password';
const errorWrongPassword = 'wrong-password';
const errorInvalidEmail = 'invalid-email';
const errorTooManyRequest = 'too-many-requests';
const errorUnknown = 'unknown';

checkError(String exception) {
  String? error;
  if (exception == errorUserNotFound) {
    error = 'No user found for that email.';
    return error;
  } else if (exception == errorWrongPassword) {
    error = 'The password is wrong. Please enter correct password.';
    return error;
  } else if (exception == errorUidAlreadyExists) {
    error = 'The account already exists for that uid.';
    return error;
  } else if (exception == errorEmailAlreadyInUse) {
    error = 'The account already exists for that email.';
    return error;
  } else if (exception == errorWeakPassword) {
    error = 'The account already exists for that email.';
    return error;
  } else if (exception == errorInvalidEmail) {
    error = 'The email address is badly formatted.';
    return error;
  } else if (exception == errorTooManyRequest) {
    error = 'Too many request.  Please try later';
    return error;
  } else if (exception == errorInvalidPassword) {
    error = 'The password is badly formatted.';
    return error;
  } else {
    error = 'An error has occurred.  Try again';
    return error;
  }
}
