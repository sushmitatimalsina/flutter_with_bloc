import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(const FormState()) {
    on<FullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<AddressChanged>((event, emit) {
      emit(state.copyWith(address: event.address));
    });
    on<GenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });
    on<FacultyChanged>((event, emit) {
      final updatedFaculties = List<String>.from(state.faculties);
      if (event.isSelected) {
        updatedFaculties.add(event.faculty);
      } else {
        updatedFaculties.remove(event.faculty);
      }
      emit(state.copyWith(faculties: updatedFaculties));
    });
    on<SubmitForm>((event, emit) {
      emit(state.copyWith(isSubmitted: true));
    });
  }
}
