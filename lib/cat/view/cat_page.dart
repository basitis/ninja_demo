import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninja_demo/cat/cat.dart';
import 'package:ninja_demo/change_cat/index.dart';
import 'package:ninja_demo/l10n/l10n.dart';

class CatPage extends StatefulWidget {
  const CatPage({super.key});

  static const String routeName = '/cat';

  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.catList),
      ),
      body: const CatScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dynamic response = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ChangeCatPage();
              },
              settings: const RouteSettings(
                name: 'AddCat',
              ),
            ),
          );
          if (response != null && response is bool && response == true) {
            if (mounted) {
              context.read<CatBloc>().add(LoadCatsEvent());
            }
          }
        },
        child: const Icon(
          Icons.plus_one,
        ),
      ),
    );
  }
}
