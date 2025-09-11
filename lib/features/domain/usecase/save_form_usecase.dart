import '../entities/form_entity.dart';
import '../repositories/form_repository.dart';

class SaveFormUseCase {
  final FormRepository repository;

  SaveFormUseCase(this.repository);

  Future<void> call(FormEntity form) {
    return repository.saveForm(form);
  }
}
