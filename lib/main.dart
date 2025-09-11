import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/bloc/form/form_bloc.dart';
import 'features/data/datasource/local_form_datasource.dart';
import 'features/presentation/pages/form_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyFormBloc(LocalFormRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLoC Form Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyFormPage(),
      ),
    );
  }
}
