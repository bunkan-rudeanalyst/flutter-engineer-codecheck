import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/provider/provider.dart';

import 'package:src/view/page/page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RepositoryProvider()),
        ],
        builder: (context, _) {
          return MaterialApp(
            title: 'GitHub Repo Search App',
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blue,
            ),
            home: HomePage(),
          );
        });
  }
}
