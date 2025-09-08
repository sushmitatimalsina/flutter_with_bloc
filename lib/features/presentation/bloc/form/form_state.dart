class FormState {
  final String name;
  final String email;
  final bool isValid;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  FormState({
    this.name = '',
    this.email = '',
    this.isValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  FormState copyWith({
    String? name,
    String? email,
    bool? isValid,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return FormState(
      name: name ?? this.name,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
