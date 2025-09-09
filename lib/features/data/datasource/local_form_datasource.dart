import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/form_entity.dart';
import '../../domain/repositories/form_repository.dart';

class LocalFormRepository implements FormRepository {
  @override
  Future<void> saveForm(FormEntity form) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', form.name);
    await prefs.setString('email', form.email);
  }

  @override
  Future<FormEntity?> loadForm() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    final email = prefs.getString('email');

    if (name != null && email != null) {
      return FormEntity(name: name, email: email);
    }
    return null;
  }
}
