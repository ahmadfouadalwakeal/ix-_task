import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ixtask/ui/Bloc_Auth/auth_bloc.dart';
import 'package:ixtask/ui/Bloc_News/news_bloc.dart';
import 'package:ixtask/ui/screens/splash_screen/SplashScreen.dart';

import '../di/Locator.dart';
import '../generated/l10n.dart';
import '../local/LanguageConstants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();
  await sl.allReady();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
    @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(ENGLISH);

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
                BlocProvider<NewsBloc>(create: (BuildContext context) => NewsBloc()),

              ],
              child: MaterialApp(
                locale: _locale,
                localizationsDelegates: [
                  S.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  brightness: Brightness.dark,
                ),
                home: const SplashScreen(),
              ),
            );

  }
}
