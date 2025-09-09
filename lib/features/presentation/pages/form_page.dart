import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasource/local_form_datasource.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';
import '../bloc/form_state.dart';
import '../../../../core/utils/custom_text_field.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/string_const.dart';

class MyFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyFormBloc(LocalFormRepository()),
      child: Scaffold(
        appBar: AppBar(title: Text('BLoC Form Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<MyFormBloc, FormState>(
            listener: (context, state) {
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Form saved successfully! ✅")),
                );
              } else if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  CustomTextField(
                    label: Name,
                    onChanged: (val) =>
                        context.read<MyFormBloc>().add(NameChanged(val)),
                  ),
                  SizedBox(height: 12),
                  CustomTextField(
                    label: Email,
                    onChanged: (val) =>
                        context.read<MyFormBloc>().add(EmailChanged(val)),
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: state.isSubmitting ? "Saving..." : Submit,
                    onPressed: state.isValid && !state.isSubmitting
                        ? () =>
                            context.read<MyFormBloc>().add(FormSubmitted())
                        : null,
                  ),
                  SizedBox(height: 20),
                  Text("Current Name: ${state.name}"),
                  Text("Current Email: ${state.email}"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
