import 'package:createmy_flutter_template/core/init/language_management/language_management.dart';
import 'package:createmy_flutter_template/core/init/notifier_management/theme_management/theme_management.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/constants/app/app_constants.dart';
import 'package:test/example/lang_example.dart';

import 'core/init/notifier_management/providers_management/providers_management.dart';

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
}

Future<void> main() async {
  // init async plugin
  await _init();
  // finaly

  runApp(
    EasyLocalization(
      supportedLocales: LanguageManagement.instance.supportedLocale,
      path: AppConstans.LANG_ASSET_PATH,
      fallbackLocale: LanguageManagement.instance.enLocale,
      saveLocale: false,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [/* ...ProvidersManagement.instance.singleItems, ...ProvidersManagement.instance.dependItems,*/ ...ProvidersManagement.instance.uiChangesItems],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: /* burda kalındı*/,
        home: const Application(),
      ),
    );
  }
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AppBody();
  }
}

class _AppBody extends StatelessWidget {
  const _AppBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(ThemeManagement.instance.themeName.toString()),
          ),
          FloatingActionButton(
            onPressed: () => ThemeManagement.instance.themeChanges(),
            child: Text('bas'),
          )
        ],
      ),
    );
  }
}
