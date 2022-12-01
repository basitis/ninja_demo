import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninja_demo/cat/cat.dart';
import 'package:ninja_demo/l10n/l10n.dart';
import 'package:ninja_demo/model/cat.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  CatScreenState createState() {
    return CatScreenState();
  }
}

class CatScreenState extends State<CatScreen> {
  CatScreenState();

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
    return BlocListener<CatBloc, CatState>(
      listener: (context, state) {
        if (state is DeleteSuccessState) {
          const SnackBar(
            content: Text('Cat deleted successfully!'),
            duration: Duration(
              seconds: 2,
            ),
          );
        }
      },
      child: BlocBuilder<CatBloc, CatState>(
        builder: (
          BuildContext context,
          CatState currentState,
        ) {
          if (currentState is CatsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is CatsEmptyState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(l10n.emptyData),
                ],
              ),
            );
          }
          if (currentState is CatsInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(l10n.loadingCat),
                ],
              ),
            );
          }
          if (currentState is CatsLoadedState) {
            return ListView(
              children: [
                ...currentState.tasks.map(
                  (e) => ListTile(
                    title: Text(e.name ?? ''),
                    leading: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: (e.image == null)
                            ? const Icon(Icons.image)
                            : Image.file(
                                File(
                                  e.image ?? '',
                                ),
                              ),
                      ),
                    ),
                    subtitle: Text(e.description ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showAlertDialog(context, l10n, e);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void showAlertDialog(BuildContext context, AppLocalizations l10n, Cat item) {
    // set up the buttons
    final Widget cancelButton = TextButton(
      child: const Text('No'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    final Widget continueButton = TextButton(
      child: const Text('Yes'),
      onPressed: () {
        context.read<CatBloc>().add(DeleteCatEvent(item));
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: Text(l10n.appName),
      content: const Text('Would you like to delete your cats?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
