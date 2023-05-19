import 'package:flutter/material.dart';
import 'package:flutter_application_3/gradle.dart';

class AddGradle extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _phaseController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Nota"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Disciplina", labelText: "Disciplina"),
                controller: _subjectController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira a disciplina da nota';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phaseController,
                decoration:
                    const InputDecoration(hintText: "Fase", labelText: "Fase"),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira a fase da nota';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(
                    hintText: "Valor", labelText: "Valor"),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira o valor da nota';
                  }
                  if (value?.isEmpty ?? true) {
                    return 'Insira o valor da nota';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Gradle gradle = Gradle(
                          phase: _phaseController.text,
                          subject: _subjectController.text,
                          value: double.parse(_valueController.text));
                      Navigator.pop(context, gradle);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
