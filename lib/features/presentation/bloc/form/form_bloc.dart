import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'form_state.dart';
import 'form_event.dart';

class MyFormBloc extends Bloc<FormEvent, FormState> {
  MyFormBloc() : super(FormState()) {
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<FormSubmitted>(_onFormSubmitted);

    _loadSavedData();
  }

  void _onNameChanged(NameChanged event, Emitter<FormState> emit) {
    emit(state.copyWith(
        name: event.name, isValid: _validateForm(event.name, state.email)));
  }

  void _onEmailChanged(EmailChanged event, Emitter<FormState> emit) {
    emit(state.copyWith(
        email: event.email, isValid: _validateForm(state.name, event.email)));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<FormState> emit) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', state.name);
      await prefs.setString('email', state.email);

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isSubmitting: false, errorMessage: 'Failed to save data'));
    }
  }

  bool _validateForm(String name, String email) {
    return name.isNotEmpty && email.contains('@');
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('name') ?? '';
    final savedEmail = prefs.getString('email') ?? '';

    if (savedName.isNotEmpty) add(NameChanged(savedName));
    if (savedEmail.isNotEmpty) add(EmailChanged(savedEmail));
  }
}
