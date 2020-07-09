import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/departamento.dart';
import 'package:moneto2/models/estadocivil.dart';
import 'package:moneto2/models/estrato.dart';
import 'package:moneto2/models/genero.dart';
import 'package:moneto2/models/geografia.dart';
import 'package:moneto2/models/localidad.dart';
import 'package:moneto2/models/municipio.dart';
import 'package:moneto2/models/tercero.dart';
import 'package:moneto2/models/tipoDeIdentificacion.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/tercero/services/service_dpto.dart';
import 'package:moneto2/screens/screensHome/tercero/servicio.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/estadocivil/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/estrato/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/genero/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/geografia/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/tipoIdentificacion/servicio.dart';
import 'package:moneto2/widgets/load.dart';

import 'list.dart';
import 'services/service_localidad.dart';
import 'services/service_municipio.dart';

import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;
import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditTercero extends StatefulWidget {
  User data_user;
  Tercero item;

  EditTercero(this.data_user, this.item);
  @override
  _Crear createState() => new _Crear();
}

class _Crear extends State<EditTercero>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");

  String _value = "Seleccionar";
  ServicioParametrizacion servicio = new ServicioParametrizacion();

  ServicioTipoidentificacion servicioTipoidentificacion =
      new ServicioTipoidentificacion();
  ServicioGenero servicioGenero = new ServicioGenero();
  ServicioEstrato servicioEstrato = new ServicioEstrato();
  ServicioEstadoCivil servicioEstadoCivil = new ServicioEstadoCivil();
  ServicioTercero servicioTercero = new ServicioTercero();
  ServicioGeografia servicioGeografia = new ServicioGeografia();

  ServiceDpto serviceDpto = new ServiceDpto();
  ServiceMunicipio serviceMunicipio = new ServiceMunicipio();
  ServiceLocalidad serviceLocalidad = new ServiceLocalidad();

  String opcionTipoIdentificacion = "Seleccionar";
  String idTipoIdentificacion;

  String opcionGenero = "Seleccionar";
  String idGenero;

  String opcionEstrato = "Seleccionar";
  String idEstrato;

  String opcionEstadoCivil = "Seleccionar";
  String idEstadoCivil;

  String opcionGeografia = "Seleccionar";
  String idGeografia = "0";

  String opcionDepartamento = "Seleccionar";
  String idDepartamento = "0";

  String opcionMunicipio = "Seleccionar";
  String idMunicipio = "0";

  String opcionLocalidad = "Seleccionar";
  String idLocalidad = "0";

  int idTercero;

  TextEditingController nombrecontroller = new TextEditingController();
  TextEditingController apellidosController = new TextEditingController();
  TextEditingController establecimientocontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController telefonocontroller = new TextEditingController();
  TextEditingController numeroController = new TextEditingController();
  TextEditingController direccionController = new TextEditingController();
  TextEditingController hijosController = new TextEditingController();
  TextEditingController _fechaController = new TextEditingController();
  Loads loads;
  bool banderaestablecimiento = false;
  int idTipoCliente = 1;
  bool bandera = false;
  bool iconsave = true;
  bool iconedit = false;
  Tercero nuevoTercero;
  String TipoCliente;

  String latitude, longitude;

  PickResult selectedPlace;
  String gps;

  bool pressMap = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    nombrecontroller.text = widget.item.nombre.toString().trim();
    apellidosController.text = widget.item.apellido.toString().trim();
    emailcontroller.text = widget.item.mail.toString();
    telefonocontroller.text = widget.item.telefono.toString();
    direccionController.text = widget.item.direccion.toString();
    numeroController.text = widget.item.nroIdentificacion.toString();

    _fechaController.text =
        format.format(DateTime.parse(widget.item.fechaNacimiento.toString()));

    hijosController.text = widget.item.hijos.toString();
    idTipoIdentificacion = widget.item.idTipoIdentificacion.toString();
    idGenero = widget.item.idGenero.toString();
    idEstrato = widget.item.idEstrato.toString();
    idEstadoCivil = widget.item.idEstadoCivil.toString();
    _value = widget.item.tipoCliente.toString();

    opcionTipoIdentificacion = widget.item.tipoIdentificacion.toString();

    opcionGenero = widget.item.genero.toString();

    opcionEstrato = widget.item.estrato.toString();

    opcionEstadoCivil = widget.item.estadoCivil.toString();

    opcionGeografia = widget.item.pais;
    idGeografia = widget.item.idPais.toString();

    opcionDepartamento = widget.item.departamento;
    idDepartamento = widget.item.idDepartamento.toString();
    opcionMunicipio = widget.item.municipio;
    idMunicipio = widget.item.idMunicipio.toString();
    opcionLocalidad = widget.item.localidad;
    idLocalidad = widget.item.idLocalidad.toString();
    latitude = widget.item.ubicacionGps.toString().split(";")[1];
    longitude = widget.item.ubicacionGps.toString().split(";")[0];
    gps = widget.item.ubicacionGps.toString().split(";")[0] +
        ";" +
        widget.item.ubicacionGps.toString().split(";")[1];

    print("GPS: " + gps);

    setState(() {});

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
                "Editar Tercero",
                style: TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListTercero(widget.data_user)));
                },
              ),
              titleSpacing: 0,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    edit();
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
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Genero:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Expanded(
                            child: FutureBuilder<List<Genero>>(
                                future: servicioGenero
                                    .getAll(widget.data_user.Token),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Genero>> snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return DropdownButton<Genero>(
                                    itemHeight: 50,
                                    style: TextStyle(color: Colors.black),
                                    items: snapshot.data
                                        .map((data) => DropdownMenuItem<Genero>(
                                              child: Text(
                                                data.nombre,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              value: data,
                                            ))
                                        .toList(),
                                    onChanged: (Genero value) {
                                      idGenero = value.idGenero.toString();

                                      opcionGenero = value.nombre;
                                      print(opcionGenero);
                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    hint: Text(
                                      opcionGenero,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Estrato Economico:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Expanded(
                            child: FutureBuilder<List<Estrato>>(
                                future: servicioEstrato
                                    .getAll(widget.data_user.Token),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Estrato>> snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return DropdownButton<Estrato>(
                                    itemHeight: 50,
                                    style: TextStyle(color: Colors.black),
                                    items: snapshot.data
                                        .map(
                                            (data) => DropdownMenuItem<Estrato>(
                                                  child: Text(
                                                    data.nombre,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  value: data,
                                                ))
                                        .toList(),
                                    onChanged: (Estrato value) {
                                      idEstrato = value.idEstrato.toString();

                                      opcionEstrato = value.nombre;
                                      print(opcionEstrato);
                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    hint: Text(
                                      opcionEstrato,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Estado Civil:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Expanded(
                            child: FutureBuilder<List<EstadoCivil>>(
                                future: servicioEstadoCivil
                                    .getAll(widget.data_user.Token),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<EstadoCivil>> snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return DropdownButton<EstadoCivil>(
                                    itemHeight: 50,
                                    style: TextStyle(color: Colors.black),
                                    items: snapshot.data
                                        .map((data) =>
                                            DropdownMenuItem<EstadoCivil>(
                                              child: Text(
                                                data.nombre,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              value: data,
                                            ))
                                        .toList(),
                                    onChanged: (EstadoCivil value) {
                                      idEstadoCivil =
                                          value.idEstadoCivil.toString();

                                      opcionEstadoCivil = value.nombre;
                                      print(opcionEstadoCivil);
                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    hint: Text(
                                      opcionEstadoCivil,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "País:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Expanded(
                            child: FutureBuilder<List<Geografia>>(
                                future: servicioGeografia
                                    .getAll(widget.data_user.Token),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Geografia>> snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return DropdownButton<Geografia>(
                                    itemHeight: 50,
                                    style: TextStyle(color: Colors.black),
                                    items: snapshot.data
                                        .map((data) =>
                                            DropdownMenuItem<Geografia>(
                                              child: Text(
                                                data.pais,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              value: data,
                                            ))
                                        .toList(),
                                    onChanged: (Geografia value) async {
                                      idGeografia = value.idPais.toString();
                                      opcionGeografia = value.pais;

                                      opcionDepartamento = "Seleccionar";
                                      idDepartamento = "0";
                                      opcionMunicipio = "Seleccionar";
                                      idMunicipio = "0";
                                      opcionLocalidad = "Seleccionar";
                                      idLocalidad = "0";

                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    hint: Text(
                                      opcionGeografia,
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
                      Visibility(
                        visible: idGeografia == "0" ? false : true,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Departamento:",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            Expanded(
                              child: FutureBuilder<List<Departamento>>(
                                  future: serviceDpto.getAll(
                                      widget.data_user.Token, idGeografia),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Departamento>>
                                          snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return DropdownButton<Departamento>(
                                      itemHeight: 50,
                                      style: TextStyle(color: Colors.black),
                                      items: snapshot.data
                                          .map((data) =>
                                              DropdownMenuItem<Departamento>(
                                                child: Text(
                                                  data.departamento,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                value: data,
                                              ))
                                          .toList(),
                                      onChanged: (Departamento value) {
                                        idDepartamento =
                                            value.idDepartamento.toString();

                                        opcionDepartamento = value.departamento;

                                        opcionMunicipio = "Seleccionar";
                                        idMunicipio = "0";
                                        opcionLocalidad = "Seleccionar";
                                        idLocalidad = "0";

                                        setState(() {});
                                      },
                                      isExpanded: true,
                                      hint: Text(
                                        opcionDepartamento,
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
                      ),
                      Visibility(
                        visible: idDepartamento == "0" ? false : true,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Municipio:",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            Expanded(
                              child: FutureBuilder<List<Municipio>>(
                                  future: serviceMunicipio.getAll(
                                      widget.data_user.Token, idDepartamento),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Municipio>> snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return DropdownButton<Municipio>(
                                      itemHeight: 50,
                                      style: TextStyle(color: Colors.black),
                                      items: snapshot.data
                                          .map((data) =>
                                              DropdownMenuItem<Municipio>(
                                                child: Text(
                                                  data.municipio,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                value: data,
                                              ))
                                          .toList(),
                                      onChanged: (Municipio value) {
                                        idMunicipio =
                                            value.idMunicipio.toString();

                                        opcionMunicipio = value.municipio;

                                        setState(() {});
                                      },
                                      isExpanded: true,
                                      hint: Text(
                                        opcionMunicipio,
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
                      ),

                      Visibility(
                        visible: idMunicipio == "0" ? false : true,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Localidad:",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            Expanded(
                              child: FutureBuilder<List<Localidad>>(
                                  future: serviceLocalidad.getAll(
                                      widget.data_user.Token, idMunicipio),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Localidad>> snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return DropdownButton<Localidad>(
                                      itemHeight: 50,
                                      style: TextStyle(color: Colors.black),
                                      items: snapshot.data
                                          .map((data) =>
                                              DropdownMenuItem<Localidad>(
                                                child: Text(
                                                  data.localidad,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                value: data,
                                              ))
                                          .toList(),
                                      onChanged: (Localidad value) {
                                        idLocalidad =
                                            value.idLocalidad.toString();

                                        setState(() {});
                                      },
                                      isExpanded: true,
                                      hint: Text(
                                        opcionLocalidad,
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
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Nombre: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                          Container(
                            width: width * 0.60,
                            height: 50,
                            child: inputField(nombrecontroller, "Nombre"),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Apellidos: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                          Container(
                            width: width * 0.60,
                            height: 50,
                            child: inputField(apellidosController, "Apellidos"),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: banderaestablecimiento,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Establecimiento: ",
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.grey),
                            ),
                            Container(
                              width: width * 0.45,
                              height: 50,
                              child: inputField(
                                  establecimientocontroller, "Establecimiento"),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Email: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                          Container(
                            width: width * 0.60,
                            height: 50,
                            child: inputField(emailcontroller, "Email"),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Telefono: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                          Container(
                            width: width * 0.60,
                            height: 50,
                            child: inputField(telefonocontroller, "Tlf"),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Tipo Identificacion:",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Expanded(
                            child: FutureBuilder<List<TipoIdentificacion>>(
                                future: servicioTipoidentificacion
                                    .getAll(widget.data_user.Token),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<TipoIdentificacion>>
                                        snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return DropdownButton<TipoIdentificacion>(
                                    itemHeight: 50,
                                    style: TextStyle(color: Colors.black),
                                    items: snapshot.data
                                        .map((data) => DropdownMenuItem<
                                                TipoIdentificacion>(
                                              child: Text(
                                                data.nombre,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              value: data,
                                            ))
                                        .toList(),
                                    onChanged: (TipoIdentificacion value) {
                                      idTipoIdentificacion =
                                          value.idTipoIdentificacion.toString();
                                      print(idTipoIdentificacion);
                                      opcionTipoIdentificacion = value.nombre;
                                      print(opcionTipoIdentificacion);
                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    hint: Text(
                                      opcionTipoIdentificacion,
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

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Numero Identificacion: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                          Container(
                            width: width * 0.35,
                            height: 50,
                            child: inputField(numeroController, "Numero"),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Direccion: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                          Container(
                            width: width * 0.60,
                            height: 50,
                            child: inputField(direccionController, "Direccion"),
                          ),
                        ],
                      ),
                      //Box para check
                      Row(
                        children: <Widget>[
                          Text("Tipo Cliente: ",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey)),
                          Expanded(
                            child: Container(
                              child: DropdownButton<String>(
                                items: [
                                  options("Cliente", "Cliente"),
                                  options("Proveedor", "Proveedor"),
                                ],
                                isExpanded: true,
                                onChanged: (String value) async {
                                  _value = value;
                                  if (_value == "Cliente") {
                                    banderaestablecimiento = false;
                                    idTipoCliente = 1;
                                  } else if (_value == "Proveedor") {
                                    banderaestablecimiento = true;
                                    idTipoCliente = 2;
                                  }
                                  print(_value);
                                  print(idTipoCliente);
                                  nuevoTercero = await servicioTercero
                                      .getTerceroByTipoAndNumero(
                                          widget.data_user.Token,
                                          idTipoIdentificacion.toString(),
                                          numeroController.text
                                              .trim()
                                              .toString());

                                  setState(() {});

                                  if (nuevoTercero == null &&
                                      numeroController.text == "") {
                                    print("no hubo registros");
                                    bandera = false;
                                  } else if (nuevoTercero != null &&
                                      numeroController.text != "") {
                                    print("hubo registros");
                                    bool shouldUpdate = await showDialog(
                                      context: this.context,
                                      child: new AlertDialog(
                                          content: Container(
                                        height: 200.0,
                                        width: 200.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Mensaje",
                                              textScaleFactor: 1.0,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.blue,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Ya existe una persona con esos mismos datos , desea utilizar los valores existentes?",
                                              textScaleFactor: 1.0,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                FlatButton(
                                                    color: Colors.blue,
                                                    child: Text(
                                                      "Si",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    }),
                                                FlatButton(
                                                    color: Colors.blue,
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    );
                                    if (shouldUpdate) {
                                      nombrecontroller.text =
                                          nuevoTercero.nombre.toString().trim();
                                      apellidosController.text = nuevoTercero
                                          .apellido
                                          .toString()
                                          .trim();
                                      emailcontroller.text =
                                          nuevoTercero.mail.toString();
                                      telefonocontroller.text =
                                          nuevoTercero.telefono.toString();
                                      direccionController.text =
                                          nuevoTercero.direccion.toString();
                                      _fechaController.text = nuevoTercero
                                          .fechaNacimiento
                                          .toString();
                                      hijosController.text =
                                          nuevoTercero.hijos.toString();

                                      idTipoIdentificacion = nuevoTercero
                                          .idTipoIdentificacion
                                          .toString();
                                      idGenero =
                                          nuevoTercero.idGenero.toString();
                                      idEstrato =
                                          nuevoTercero.idEstrato.toString();
                                      idEstadoCivil =
                                          nuevoTercero.idEstadoCivil.toString();

                                      idGeografia =
                                          nuevoTercero.idPais.toString();
                                      opcionGeografia = nuevoTercero.pais;

                                      idDepartamento = nuevoTercero
                                          .idDepartamento
                                          .toString();
                                      opcionDepartamento =
                                          nuevoTercero.departamento;

                                      idMunicipio =
                                          nuevoTercero.idMunicipio.toString();
                                      opcionMunicipio = nuevoTercero.municipio;

                                      idLocalidad =
                                          nuevoTercero.idLocalidad.toString();
                                      opcionLocalidad = nuevoTercero.localidad;

                                      iconsave = false;
                                      iconedit = true;
                                      setState(() {});
                                    } else {
                                      print("false");
                                    }
                                  }
                                },
                                hint: Text(_value),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "# de Hijos: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                          Container(
                            width: width * 0.40,
                            height: 50,
                            child: inputField(hijosController, "Hijos"),
                          ),
                        ],
                      ),
                      DateTimeField(
                        controller: _fechaController,
                        validator: (value) {
                          if (value == "") {
                            return 'Requerido*';
                          }
                          return null;
                        },
                        format: format,
                        decoration: InputDecoration(labelText: "Fecha"),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: Constants.darkPrimary,
                        onPressed: () async {
                          pressMap = true;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PlacePicker(
                                  apiKey:
                                      "AIzaSyB0l2oyv6YZpUuNCt-GofRNd14XP0q4yP8",
                                  useCurrentLocation: false,
                                  usePlaceDetailSearch: true,
                                  selectInitialPosition: true,
                                  forceSearchOnZoomChanged: true,
                                  initialPosition: LatLng(
                                    double.parse(longitude),
                                    double.parse(latitude),
                                  ),
                                  selectedPlaceWidgetBuilder: (context, data,
                                      state, isSearchBarFocused) {
                                    return isSearchBarFocused
                                        ? Container()
                                        : FloatingCard(
                                            bottomPosition:
                                                0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                            leftPosition: 0.0,
                                            rightPosition: 0.0,
                                            width: 500,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: state ==
                                                    SearchingState.Searching
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : _buildSelectionDetails(
                                                    context, data),
                                          );
                                  },
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Marcar el Mapa',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      selectedPlace == null
                          ? Container()
                          : Text("Dirección: " +
                              selectedPlace.geometry.location.lat.toString() +
                              ";" +
                              selectedPlace.geometry.location.lng.toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildSelectionDetails(BuildContext context, PickResult result) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RaisedButton(
        color: Constants.darkPrimary,
        child: Text(
          "Seleccionar Dirección: " + result.formattedAddress,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          selectedPlace = result;

          setState(() {});

          Navigator.of(context).pop();
        },
      ),
    );
  }

  showDialogBox<bool>(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Center(
                // Aligns the container to center
                child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                // A simplified version of dialog.
                width: 300, //ancho
                height: 200, // alto
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Mensaje",
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Existe algun registro ya almacenado deseas editarlo?",
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CupertinoButton(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.blue,
                            child: Text(
                              "Si",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                            }),
                        CupertinoButton(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.blue,
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget options(String texto, String value) {
    return DropdownMenuItem<String>(
      child: Row(
        children: <Widget>[
          /* Icon(Icons.radio_button_checked,
          color: Colors.blue,
          ), */
          Text(texto),
        ],
      ),
      value: value,
    );
  }

  Widget inputField(TextEditingController controller, String label) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Requerido';
        }
        return null;
      },
      decoration: InputDecoration(
          //labelText: label,
          /// border: InputBorder.none,
          ),
      keyboardType: TextInputType.text,

      controller: controller,
      textInputAction: TextInputAction.done,
      onChanged: (va) {},
      // focusNode: _local,
    );
  }

  edit() async {
    if (_formKey.currentState.validate() && _fechaController.text != null) {
      Tercero nuevo = new Tercero();

      if (_value == "Cliente") {
        //dia = "";
        establecimientocontroller.text = "";
      }
      if (pressMap == true) {
        gps = selectedPlace.geometry.location.lat.toString() +
            ";" +
            selectedPlace.geometry.location.lng.toString();
      }

      Map data = nuevo.convertMapOP(
          widget.item.idTercero,
          nombrecontroller.text.trim().toString(),
          apellidosController.text.trim().toString(),
          establecimientocontroller.text.trim().toString(),
          int.parse(idTipoIdentificacion),
          numeroController.text.trim().toString(),
          emailcontroller.text.trim().toString(),
          telefonocontroller.text.trim().toString(),
          _fechaController.text.trim().toString(),
          hijosController.text.trim().toString(),
          direccionController.text.trim().toString(),
          int.parse(idGenero),
          idTipoCliente,
          int.parse(idEstrato),
          int.parse(idEstadoCivil),
          gps,
          idGeografia,
          idDepartamento,
          idMunicipio,
          idLocalidad);

      print("DATA: " + data.toString());
      //al servicio

      var success = await servicio.editTercero(
          widget.data_user.Token, data, context, 'api/Tercero/Update');
      if (success == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListTercero(widget.data_user),
            ));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }

  delete() async {
    await servicio.delete(widget.data_user.Token,
        widget.item.idTercero.toString(), context, 'api/Tercero/Delete/');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ListTercero(widget.data_user)));
  }
}
