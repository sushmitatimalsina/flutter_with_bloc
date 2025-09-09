abstract class FormRepository {
  Future<void> saveForm(FormEntity form);
  Future<FormEntity?> loadForm();
}
