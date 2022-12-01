import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ninja_demo/change_cat/cubit/change_cat_bloc.dart';
import 'package:ninja_demo/change_cat/cubit/change_cat_event.dart';
import 'package:ninja_demo/change_cat/cubit/change_cat_state.dart';
import 'package:ninja_demo/l10n/l10n.dart';
import 'package:ninja_demo/model/cat_properties.dart';

class ChangeCatScreen extends StatefulWidget {
  const ChangeCatScreen({
    super.key,
  });

  @override
  ChangeCatScreenState createState() {
    return ChangeCatScreenState();
  }
}

class ChangeCatScreenState extends State<ChangeCatScreen> {
  ChangeCatScreenState();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<ChangeCatBloc, ChangeCatState>(
      listener: (
        BuildContext context,
        ChangeCatState currentState,
      ) {
        if (currentState is SuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Cat Added!'),
              action: SnackBarAction(
                label: 'Okay',
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          );
        }
        if (currentState is ErrorState) {
          SnackBar(
            content: Text(currentState.errorMessage),
            duration: const Duration(
              seconds: 2,
            ),
          );
        }
      },
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<ChangeCatBloc, ChangeCatState>(
                        buildWhen: (previous, current) {
                          return current is CatPhotoSuccessState;
                        },
                        builder: (
                          BuildContext context,
                          ChangeCatState currentState,
                        ) {
                          if (currentState is CatPhotoSuccessState) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<ChangeCatBloc>()
                                    .add(AddCatPhotoEvent());
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.file(File(currentState.path)),
                                ),
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<ChangeCatBloc>()
                                  .add(AddCatPhotoEvent());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              child: const AspectRatio(
                                aspectRatio: 1,
                                child: Icon(Icons.photo),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onSaved: (String? value) {
                          context.read<ChangeCatBloc>().add(
                                ValueChangeEvent(
                                  CatProperties.name,
                                  value ?? '',
                                ),
                              );
                        },
                        validator: ValidationBuilder()
                            .required(l10n.validationName)
                            .maxLength(50)
                            .build(),
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        onSaved: (String? value) {
                          context.read<ChangeCatBloc>().add(
                                ValueChangeEvent(
                                  CatProperties.breed,
                                  value ?? '',
                                ),
                              );
                        },
                        validator: ValidationBuilder()
                            .required(l10n.validationName)
                            .maxLength(30)
                            .build(),
                        decoration: const InputDecoration(labelText: 'Breed'),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        onSaved: (String? value) {
                          context.read<ChangeCatBloc>().add(
                                ValueChangeEvent(
                                  CatProperties.description,
                                  value ?? '',
                                ),
                              );
                        },
                        validator: ValidationBuilder()
                            .required(l10n.validationName)
                            .maxLength(30)
                            .build(),
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final isValid = _form.currentState?.validate();
                  debugPrint('isvalid $isValid');
                  if (isValid != null && isValid) {
                    _form.currentState?.save();
                    context.read<ChangeCatBloc>().add(SubmitFormEvent());
                  } else {
                    context
                        .read<ChangeCatBloc>()
                        .add(ErrorCatEvent('Please enter all valid details!'));
                  }
                },
                child: Text(
                  'Add Cat',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
