import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_form_bloc.dart';
import 'form_event.dart';
import 'form_state.dart';
import '../../../core/utils/custom_text_field.dart';
import '../../../core/utils/custom_button.dart';

class MyFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyFormBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('BLoC Form Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<MyFormBloc, FormState>(
            listener: (context, state) {
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Form submitted and saved locally!')),
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
                    label: 'Name',
                    initialValue: state.name,
                    onChanged: (val) =>
                        context.read<MyFormBloc>().add(NameChanged(val)),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Email',
                    initialValue: state.email,
                    onChanged: (val) =>
                        context.read<MyFormBloc>().add(EmailChanged(val)),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: state.isSubmitting ? 'Saving...' : 'Submit',
                    onPressed: state.isValid && !state.isSubmitting
                        ? () =>
                            context.read<MyFormBloc>().add(FormSubmitted())
                        : () {},
                  ),
                  const SizedBox(height: 20),
                  Text('Saved Data:'),
                  Text('Name: ${state.name}'),
                  Text('Email: ${state.email}'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
