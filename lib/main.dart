import 'package:aplicativo_libras/services/learn_manager.dart';
import 'package:aplicativo_libras/services/parametros_manager.dart';
import 'package:aplicativo_libras/services/user_manager.dart';
import 'package:aplicativo_libras/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserManager(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => LearnManager(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => ParametroManager(),
            lazy: false,
          ),
        ],
        child:MaterialApp(
          title: 'Sinaliza',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [const Locale('pt', 'BR')],
          home: SplashPage(),
        )
    );
  }
}
