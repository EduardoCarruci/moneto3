import 'package:flutter/material.dart';
import 'package:moneto2/models/color.dart';
import 'package:moneto2/models/user.dart';

import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/color/servicio.dart';
import 'package:moneto2/vistas/principales/home.dart';
import 'package:moneto2/widgets/load.dart';

class EditColor extends StatefulWidget {
  User data_user;

  EditColor(this.data_user);

  @override
  _EditColorState createState() => _EditColorState();
}

class _EditColorState extends State<EditColor> {
  Loads loads;

  ServicioColor servicioColor = new ServicioColor();
  ServicioParametrizacion servicioParametrizacion =
      new ServicioParametrizacion();

  String opcionColor = "Seleccionar";
  String idColorAPP;
  String colorhex;

  @override
  void initState() {
    super.initState();
    opcionColor = widget.data_user.tipoCliente.colorApp.toString();
    idColorAPP = widget.data_user.tipoCliente.idColorApp.toString();
    colorhex = widget.data_user.tipoCliente.colorHexaApp.toString();
    print(opcionColor);
    print(idColorAPP);
    print(colorhex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Constants.darkPrimary,
              title: Text(
                "Editar Configuración",
                style: TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(widget.data_user)));
                },
              ),
              titleSpacing: 0,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    update();
                  },
                  iconSize: 20,
                ),
              ],
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/color.png",
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Color: ",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      Expanded(
                        child: FutureBuilder<List<ColorApp>>(
                            future:
                                servicioColor.getAll(widget.data_user.Token),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ColorApp>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButton<ColorApp>(
                                itemHeight: 50,
                                style: TextStyle(color: Colors.black),
                                items: snapshot.data
                                    .map((data) => DropdownMenuItem<ColorApp>(
                                          child: Text(
                                            data.nombre,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          value: data,
                                        ))
                                    .toList(),
                                onChanged: (ColorApp value) {
                                  idColorAPP = value.idColorAPP.toString();

                                  opcionColor = value.nombre;
                                  colorhex = value.colorHexa.toString();

                                  print("ID: " + idColorAPP.toString());
                                  print("Color: " + opcionColor.toString());
                                  print("HEX: " + colorhex.toString());

                                  setState(() {});
                                },
                                isExpanded: true,
                                hint: Text(
                                  opcionColor,
                                  style: TextStyle(fontSize: 16),
                                ),
                                icon: Icon(Icons.arrow_downward),
                                /*  value: value[],
                                                    hint: Text(""), */
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        ));
  }

  update() async {
    ColorApp item = new ColorApp();

    Map data =
        item.convertMapOP(widget.data_user.idUsuario, int.parse(idColorAPP));

    var valor = await servicioParametrizacion.editTercero(
        widget.data_user.Token, data, context, 'api/usuarios/configuracion');
    if (valor == "200") {
      print("SUCCESS");

      String colors = colorhex.split("#")[1];

      widget.data_user.tipoCliente.colorHexaApp =colorhex;
      print(colors);
      colors = "0xff" + colors;
      print(colors);
      Constants.darkPrimary = Color(int.parse(colors));
      setState(() {});

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Home(widget.data_user)));
    } else {
      print(" NO SUCCESS");
    }
  }
}
