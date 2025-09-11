import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/form_entity.dart';
import '../../../domain/repositories/form_repository.dart';
import 'form_event.dart';
import 'form_state.dart';

class MyFormBloc extends Bloc<FormEvent, FormState> {
  final FormRepository repository;

  MyFormBloc(this.repository) : super(FormState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<FormSubmitted>((event, emit) async {
      if (!state.isValid) {
        emit(state.copyWith(errorMessage: "Invalid input"));
        return;
      }

      emit(state.copyWith(isSubmitting: true));

      try {
        await repository.saveForm(FormEntity(
          name: state.name,
          email: state.email,
        ));

        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (_) {
        emit(state.copyWith(
            isSubmitting: false, errorMessage: "Failed to save form"));
      }
    });
  }
}
