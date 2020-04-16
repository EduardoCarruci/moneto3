import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/home.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/widgets/load.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

Future<bool> _willPopCallback() async {
  return false; // return true if the route to be popped
}

class _LoginState extends State<Login> {
  TextEditingController _usuarioController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final FocusNode _usuario = FocusNode();
  final FocusNode _clave = FocusNode();
  User data_user;
  Loads loads;

  bool _lights = false;

  @override
  void initState() {
    super.initState();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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
        home: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(0.0), // here the desired height
                child: AppBar(
                  backgroundColor: Constants.Gra1,
                  brightness: Brightness.dark,
                )),
            body: WillPopScope(
              onWillPop: () => _willPopCallback(),
              child: Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height * 1.3,
                      //  #510C3D
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration:
                          new BoxDecoration(gradient: Constants.gradiente),

                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Icon(Icons.monetization_on),
                            flex: 3,
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
                                onChanged: (tes) {},
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Requerido*';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                controller: _usuarioController,
                                keyboardType: TextInputType.text,
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
                                onChanged: (tes) {},
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
                              //aca deberiamos entrar al home
                              //generartoken

                              generateToken();
                            },
                            color: Constants.Button1,
                            child: Text('Entrar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
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
        ));
  }

  generateToken() async {
    //loads.Carga("Verificando...");
    
    var url = "http://198.72.112.52:8080/api/login/authenticate";
    http.post(url, body: {
      "Username": "admin",
      "Password": "admin_LaSolucion"
    }).then((response) {
      if (response.statusCode == 200) {
        var bod = response.body.toString();
        var to = bod.split(':');
        var token = to[1].split('"');
        print(token[0].trim());
        data_user = new User(1, "Carlos", token[0].trim()); // HARDCODEADO
        Login(token[0].trim());
      } else if (response.statusCode >= 300) {
        //loads.cerrar();
        // loads.Toast_Resull(2, "Los datos ingresados son incorrectos");
        //loads.Toast_Resull(2, "Los datos ingresados son incorrectos");
        print("Desde generar token " + response.statusCode.toString());
      }
    });
  }

  Future Login(var token) async {
    // rg@gmail.com
    //1211
    
    final response = await http.get(
      'http://198.72.112.52:8080/api/usuarios/Login?mail=${_usuarioController.text}&password=${_passwordController.text}',
      headers: {HttpHeaders.authorizationHeader: token},
    );
    print(" desd el get " + response.body);
    if (response.statusCode == 200) {
      var tokeem = response.body;
      print("Response del Login: " + tokeem);
      //loads.cerrar();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home(data_user)));
    } else if (response.statusCode >= 300) {
      //  Navigator.pop(context);
      // loads.Toast_Resull(2,"Los datos ingresados son incorrectos");
      print("Desde paso 2 " + response.statusCode.toString());
      // loads.cerrar();
    }
  }
}
