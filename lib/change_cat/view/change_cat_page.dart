import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninja_demo/change_cat/cubit/change_cat_bloc.dart';
import 'package:ninja_demo/change_cat/index.dart';
import 'package:ninja_demo/l10n/l10n.dart';
import 'package:ninja_demo/services/cat_service.dart';

class ChangeCatPage extends StatefulWidget {
  const ChangeCatPage({super.key});

  static const String routeName = '/changeCat';

  @override
  _ChangeCatPageState createState() => _ChangeCatPageState();
}

class _ChangeCatPageState extends State<ChangeCatPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(l10n.changeCat),
      ),
      body: BlocProvider(
        create: (context) => ChangeCatBloc(
          RepositoryProvider.of<CatService>(context),
        ),
        child: const ChangeCatScreen(),
      ),
    );
  }
}
