import 'package:flutter/material.dart';
import 'package:moneto2/utils/provider.dart';
import 'package:moneto2/vistas/principales/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderInfo(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            //const Locale('en'), // English
            const Locale('es','ES'), // Hebrew
          
          ],
          title: 'MONETO2',
          initialRoute: 'login',
          routes: {
            'login': (BuildContext context) => Login(),
          }),
    );
  }
}
