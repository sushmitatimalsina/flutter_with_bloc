abstract class FormEvent {}

class NameChanged extends FormEvent {
  final String name;
  NameChanged(this.name);
}

class EmailChanged extends FormEvent {
  final String email;
  EmailChanged(this.email);
}

class FormSubmitted extends FormEvent {}
