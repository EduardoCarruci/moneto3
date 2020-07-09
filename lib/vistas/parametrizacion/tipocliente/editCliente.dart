import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/cabecerametadata.dart';
import 'package:moneto2/models/color.dart';
import 'package:moneto2/models/idiomas.dart';
import 'package:moneto2/models/tipoCliente.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/cabeceraMetadata/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/color/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/idiomas/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/tipocliente/list.dart';
import 'package:moneto2/widgets/load.dart';

class EditCliente extends StatefulWidget {
  User data_user;

  TipoCliente item;

  EditCliente(this.data_user, this.item);

  @override
  _Edit createState() => new _Edit();
}

class _Edit extends State<EditCliente>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController _NombreController = new TextEditingController();

  TextEditingController _CodigoController = new TextEditingController();

  ServicioParametrizacion servicio = new ServicioParametrizacion();

  ServicioIdiomas servicioIdioma = new ServicioIdiomas();
  ServicioCabeceraMetadata servicioMetadata = new ServicioCabeceraMetadata();
  ServicioColor servicioColor = new ServicioColor();

  Loads loads;

  final _formKey = GlobalKey<FormState>();

  String opcionidioma = "Seleccionar";
  String idIdioma;

  String opcionMetadata = "Seleccionar";
  String idMetadata;

  String opcionColor = "Seleccionar";
  String idColor;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    _NombreController = new TextEditingController(text: widget.item.nombre);
    _CodigoController = new TextEditingController(text: widget.item.codigo);
    opcionidioma = widget.item.idioma;
    idIdioma = widget.item.idIdioma.toString();
    opcionMetadata = widget.item.CabeceraMetadata;
    idMetadata = widget.item.idCabeceraMetadata.toString();
    opcionColor = widget.item.colorApp;
    idColor = widget.item.idColorApp.toString();

    print(opcionidioma);
    print(idIdioma);
    print(opcionMetadata);
    print(idMetadata);
    /*  print(opcionColor);
    print(idColor); */

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.darkPrimary,
              title: Text(
                "Editar Tipo Cliente",
                style: TextStyle(fontSize: 18),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListTipoCliente(widget.data_user)));
                },
              ),
              titleSpacing: 0,
              //centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    update();
                  },
                  iconSize: 20,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    delete();
                  },
                  iconSize: 20,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Codigo:",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      Container(
                        //color: Colors.red,
                        width: width * 0.90,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Requerido';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              //labelText: "Codigo",
                              //border: InputBorder.none,
                              ),
                          keyboardType: TextInputType.text,

                          controller: _CodigoController,
                          textInputAction: TextInputAction.done,
                          onChanged: (va) {},
                          // focusNode: _local,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Tipo Cliente:",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      Container(
                        //color: Colors.red,
                        width: width * 0.90,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Requerido';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              //labelText: "Nombre",
                              //border: InputBorder.none,
                              ),
                          keyboardType: TextInputType.text,

                          controller: _NombreController,
                          textInputAction: TextInputAction.done,
                          onChanged: (va) {},
                          // focusNode: _local,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        //color: Colors.red,
                        width: width * 0.90,
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              /*   mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly, */
                              children: <Widget>[
                                Text(
                                  "Idioma:",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                                SizedBox(width: 20.0),
                                Container(
                                  // color: Colors.green,
                                  child: FutureBuilder<List<Idioma>>(
                                      future: servicioIdioma
                                          .getAll(widget.data_user.Token),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<Idioma>>
                                              snapshot) {
                                        if (!snapshot.hasData)
                                          return CircularProgressIndicator();
                                        return DropdownButton<Idioma>(
                                          itemHeight: 50,
                                          style: TextStyle(color: Colors.black),
                                          items: snapshot.data
                                              .map((data) =>
                                                  DropdownMenuItem<Idioma>(
                                                    child: Text(
                                                      data.descripcion,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    ),
                                                    value: data,
                                                  ))
                                              .toList(),
                                          onChanged: (Idioma value) {
                                            idIdioma =
                                                value.idIdioma.toString();
                                            print(value.idIdioma);
                                            print(value.descripcion);
                                            opcionidioma = value.descripcion;
                                            setState(() {});
                                          },
                                          isExpanded: false,
                                          hint: Text(
                                            opcionidioma,
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
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Colores:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          FutureBuilder<List<ColorApp>>(
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
                                    idColor = value.idColorAPP.toString();
                                    opcionColor = value.nombre;
                                    setState(() {});
                                    print(opcionColor.toString());
                                    print(idColor.toString());
                                  },
                                  isExpanded: false,
                                  hint: Text(
                                    opcionColor,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  icon: Icon(Icons.arrow_downward),
                                  /*  value: value[],
                                              hint: Text(""), */
                                );
                              }),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Metadata:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          FutureBuilder<List<CabeceraMetadata>>(
                              future: servicioMetadata
                                  .getCabeceraMetadata(widget.data_user.Token),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<CabeceraMetadata>>
                                      snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return DropdownButton<CabeceraMetadata>(
                                  itemHeight: 50,
                                  style: TextStyle(color: Colors.black),
                                  items: snapshot.data
                                      .map((data) =>
                                          DropdownMenuItem<CabeceraMetadata>(
                                            child: Text(
                                              data.nombre,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            value: data,
                                          ))
                                      .toList(),
                                  onChanged: (CabeceraMetadata value) {
                                    idMetadata =
                                        value.idCabeceraMetadata.toString();
                                    print(value.idCabeceraMetadata);
                                    print(value.nombre);
                                    opcionMetadata = value.nombre;
                                    setState(() {});
                                  },
                                  isExpanded: false,
                                  hint: Text(
                                    opcionMetadata,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  icon: Icon(Icons.arrow_downward),
                                  /*  value: value[],
                                              hint: Text(""), */
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  update() async {
    if (_formKey.currentState.validate()) {
      TipoCliente nuevo = new TipoCliente();
      Map data = nuevo.convertMapOP(
          widget.item.idTipoCliente,
          _CodigoController.text.trim().toString(),
          _NombreController.text.trim().toString(),
          idIdioma,
          idColor,
          idMetadata);
      print(data);
      var success = await servicio.edit(
          widget.data_user.Token,
          data,
          widget.item.idTipoCliente.toString(),
          context,
          'api/TipoCliente/Update/');
      print(success);
      if (success == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListTipoCliente(widget.data_user)));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
    var cambios = await servicio.delete(
        widget.data_user.Token,
        widget.item.idTipoCliente.toString(),
        context,
        'api/TipoCliente/Delete/');

    if (cambios == "200") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListTipoCliente(widget.data_user)));
    }
  }
}
