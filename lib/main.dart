import 'package:flutter/material.dart';
import 'package:moneto2/vistas/principales/login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PECT-CALCULO',
        initialRoute: 'login',

        //MAPA DE RUTAS
        routes: {

           'login': (BuildContext context) => Login(),
/*          
          'preciototal': (BuildContext context) => PrecioTotal(),
          'listprecios': (BuildContext context) => ListPrecios(),
          'user': (BuildContext context) => User(),
          'terreno': (BuildContext context) => Terreno(),
          'casa': (BuildContext context) => Casa(), */
        });
  }
}
