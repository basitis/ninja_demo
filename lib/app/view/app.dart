// Copyright (c) 2022, Bhavin S Doshi
//
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninja_demo/cat/cat.dart';
import 'package:ninja_demo/change_cat/cubit/change_cat_bloc.dart';
import 'package:ninja_demo/l10n/l10n.dart';
import 'package:ninja_demo/services/cat_service.dart';
import 'package:ninja_demo/services/image_helper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CatService()),
        RepositoryProvider(create: (context) => ImageHelper()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CatBloc>(
            create: (context) => CatBloc(
              RepositoryProvider.of<CatService>(context),
              RepositoryProvider.of<ImageHelper>(context),
            )..add(RegisterServicesEvent()),
          ),
          BlocProvider<ChangeCatBloc>(
            create: (context) => ChangeCatBloc(
              RepositoryProvider.of<CatService>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: FlexThemeData.light(
            scheme: FlexScheme.indigo,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 9,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 10,
              blendOnColors: false,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
          ),
          darkTheme: FlexThemeData.dark(
            scheme: FlexScheme.indigo,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 15,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 20,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const CatPage(),
        ),
      ),
    );
  }
}
