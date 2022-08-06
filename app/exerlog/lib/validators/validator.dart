class ValidationError {
  final String? message;
  const ValidationError({this.message = "Validation Error"});
}

abstract class Validator<T> {
  const Validator._({required this.value});
  final T value;

  // sets input value to the validator
  const Validator.set(T value) : this._(value: value);

  // getter for validation error
  ValidationError? get error => validator(value);

  // checks if the input value is valid
  bool get isValid => validator(value) == null;

  // validator function, return null if valid and ValidationError when invalid
  ValidationError? validator(T value);
}

// Group Validation of input values
class GroupValidator {
  final List<Validator> validators;
  const GroupValidator({required this.validators});
  bool get isValid {
    return validators.every((validator) {
      return validator.isValid;
    });
  }

  // return the first error from the group
  ValidationError get error {
    return validators.firstWhere((validator) => !validator.isValid).error!;
  }
}
