import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:http/http.dart' as http;
import 'package:moneto2/utils/controllerbd.dart';
import 'package:moneto2/vistas/principales/home.dart';
import 'package:moneto2/widgets/load.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usuarioController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final FocusNode _usuario = FocusNode();
  final FocusNode _clave = FocusNode();
  final _formKey = GlobalKey<FormState>();
  User data_user;
  Loads loads;
  bool _lights = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  @override
  void initState() {
    super.initState();
    _usuarioController.text = "admin@gmail.com";
    _passwordController.text = "admin"; //admin
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Seguro que quieres salir?'),
            //content: Text('Selecciona tu opción'),
            actions: <Widget>[
              Container(
                //color: Colors.red,
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/emojianswer.png"),
                  height: 100,
                  width: 100,
                ),
              ),
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  'Sí',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  exit(0);
                  //Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Moneto2",
      theme: ThemeData(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
          primaryColor: Colors.white,
          accentColor: Colors.white,
          hintColor: Colors.white,
          dialogTheme: DialogTheme(
            backgroundColor: Colors.deepPurple,
          )

          //  cursorColor: Colors.white
          ),
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async  {
          exit(0);
        },
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Container(
                  /* 0 */
                  //  #510C3D
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: new BoxDecoration(gradient: Constants.gradiente),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Icon(Icons.monetization_on),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              focusNode: _usuario,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(context, _usuario, _clave);
                              },
                              decoration: InputDecoration(
                                // hintText: 'What do people call you?',
                                //  icon: Icon(Icons.phone_android),
                                labelText: 'Usuario',

                                //icon: Icon(Icons.check_circle,color: Colors.green,),
                              ),
                              onChanged: (tes) {
                                if (tes != null) {
                                  _formKey.currentState.validate();
                                }
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Requerido*';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              controller: _usuarioController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              focusNode: _clave,
                              decoration: InputDecoration(
                                // hintText: 'What do people call you?',
                                // icon: Icon(Icons.https),
                                labelText: 'Contraseña',
                                fillColor: Colors.white,

                                //icon: Icon(Icons.check_circle,color: Colors.green,),
                              ),
                              onChanged: (tes) {
                                if (tes != null) {
                                  _formKey.currentState.validate();
                                }
                              },
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Requerido*';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: SwitchListTile(
                              value: _lights,
                              selected: true,
                              title: new Text('Recordar contraseña',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14)),
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.grey,
                              onChanged: (bool value) {
                                setState(() {});
                              },
                            ),
                          )),
                          flex: 1,
                        ),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 40.0,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              generateToken();
                            } else {
                              loads = new Loads(context);
                              loads.toast(2, "Los campos son Invalidos");
                            }
                          },
                          color: Constants.Button1,
                          child: Text('Entrar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: GestureDetector(
                                    child: new Text(
                                        '¿No tienes usuario? Regístrate aquí',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 14)),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: GestureDetector(
                                      child: new Text('Recuperar contraseña',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 14)),
                                      onTap: () {
                                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => Recuperar()));
                                      },
                                    ),
                                  )),
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  generateToken() async {
    //loads.Carga("Verificando...");

    loads = new Loads(context);

    loads.progressCarga("Validando Datos");
    //http://198.72.112.52/Monetapi/api/login/authenticate
    //http://198.72.112.52/Monetapi/
    //http://108.163.146.164/Monetapi
    var url = "http://108.163.146.164/Monetapi/api/login/authenticate";
    http.post(url, body: {
      "Username": "admin",
      "Password": "admin_LaSolucion"
    }).then((response) {
      if (response.statusCode == 200) {
        var bod = response.body.toString();
        var to = bod.split(':');
        var token = to[1].split('"');
        print(token[0].trim());
        //data_user = new User(1, "Carlos", token[0].trim(),"7"); // HARDCODEADO

        //print("RESBODY: "+resBody);
        loads.cerrar();

        Login(token[0].trim());
      } else if (response.statusCode >= 300) {
        loads.toast(2, " Datos Incorrectos");
        loads.cerrar();

        loads.cerrar();
        print("CAISTE ACA");
      }
    });
  }

  Future Login(var token) async {
    // rg@gmail.com
    //1211

    final response = await http.get(
      'http://108.163.146.164/Monetapi/api/usuarios/Login?mail=${_usuarioController.text.trim()}&password=${_passwordController.text}',
      headers: {HttpHeaders.authorizationHeader: token},
    );

    if (response.statusCode == 200) {
      loads.cerrar();

      print(response.body);

      final user = User.fromJson(response.body);
      user.Token = token;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home(user)));
    } else if (response.statusCode >= 300) {
      loads.toast(2, "Los datos ingresados son incorrectos");
      // loads.cerrar();
      //Navigator.pop(context);
      loads.cerrar();
    }
  }
}
