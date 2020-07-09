import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;
import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/categoriapadre.dart';
import 'package:moneto2/models/cuentacontable.dart';
import 'package:moneto2/models/departamento.dart';
import 'package:moneto2/models/estadocivil.dart';
import 'package:moneto2/models/estrato.dart';
import 'package:moneto2/models/genero.dart';
import 'package:moneto2/models/geografia.dart';
import 'package:moneto2/models/iep.dart';
import 'package:moneto2/models/localidad.dart';
import 'package:moneto2/models/municipio.dart';
import 'package:moneto2/models/referencias.dart';
import 'package:moneto2/models/tercero.dart';
import 'package:moneto2/models/tipoDeIdentificacion.dart';
import 'package:moneto2/models/tipomediopago.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/iep/list.dart';
import 'package:moneto2/screens/screensHome/iep/servicio.dart';
import 'package:moneto2/screens/screensHome/tercero/services/service_dpto.dart';
import 'package:moneto2/screens/screensHome/tercero/services/service_localidad.dart';
import 'package:moneto2/screens/screensHome/tercero/services/service_municipio.dart';
import 'package:moneto2/screens/screensHome/tercero/servicio.dart';
import 'package:moneto2/screens/screensHome/tipoconcepto/servicio.dart';
import 'package:moneto2/utils/Const.dart';

import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/cuentacontable/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/estadocivil/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/estrato/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/genero/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/geografia/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/tipoIdentificacion/servicio.dart';
import 'package:moneto2/widgets/load.dart';

class CreateList extends StatefulWidget {
  User user;
  String valor;
  CreateList(this.user, this.valor);
  @override
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<CreateList> {
  final _formKey = GlobalKey<FormState>();
  final _form2Key = GlobalKey<FormState>();

  ServicioTipoConcepto servicioTipoConcepto = new ServicioTipoConcepto();
  ServicioTercero servicioTercero = new ServicioTercero();
  ServicioCuentaContable servicioCuenta = new ServicioCuentaContable();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  ServicioIEP servicioIEP = new ServicioIEP();
  final format = DateFormat("yyyy-MM-dd");
  //TextEditingController controllerdinero = new TextEditingController();
  TextEditingController controllerref = new TextEditingController();
  TextEditingController controllerfecha = new TextEditingController();
  TextEditingController controllerdocumento = new TextEditingController();
  TextEditingController controllervalor = new TextEditingController();
  Loads loads;

  String total = "0";

  String opciontipoconcepto = "Seleccionar";
  String idtipoconcepto;

  String opcionCategoria = "Seleccionar";
  String idCategoriaHija;

  String opcionTercero = "Seleccionar";
  String idTercero;

  String opcionReferencia = "Seleccionar";
  String idReferencia = null;

  List<Detalleconcepto> listconceptos = new List<Detalleconcepto>();

  String textoConceptos = "Sin Conceptos Agregados";

  //---------------TERCEROS

  ServicioGenero servicioGenero = new ServicioGenero();
  ServicioEstrato servicioEstrato = new ServicioEstrato();
  ServicioEstadoCivil servicioEstadoCivil = new ServicioEstadoCivil();
  ServicioTipoidentificacion servicioTipoidentificacion =
      new ServicioTipoidentificacion();
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

  int idPopUpTercero;

  TextEditingController nombrecontroller = new TextEditingController();
  TextEditingController apellidosController = new TextEditingController();
  TextEditingController establecimientocontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController telefonocontroller = new TextEditingController();
  TextEditingController numeroController = new TextEditingController();
  TextEditingController direccionController = new TextEditingController();
  TextEditingController hijosController = new TextEditingController();
  TextEditingController _fechaController = new TextEditingController();
  LocationResult _pickedLocation;
  Tercero nuevoTercero;
  String _value = "Seleccionar";
  bool banderaestablecimiento = false;
  int idTipoCliente = 1;
  bool bandera = false;
  bool iconsave = true;
  bool iconedit = false;

  PickResult selectedPlace;
  @override
  void initState() {
    // TODO: implement initState
    print(widget.valor);

    servicioTercero.getAll(widget.user.Token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //  final width = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    // final provider = Provider.of<ProviderInfo>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "Añadir",
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IEP(widget.user, widget.valor)));
              },
            ),
            titleSpacing: 0,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person_add),
                iconSize: 20,
                color: Colors.white,
                onPressed: () async {
                  dialog(screenWidth);
                },
              ),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  if (_form2Key.currentState.validate() &&
                      opciontipoconcepto != "Seleccionar") {
                    Detalleconcepto nuevo = new Detalleconcepto();
                    nuevo.idTipoConcepto = int.parse(idtipoconcepto);
                    nuevo.tipoConcepto = opciontipoconcepto;
                    nuevo.fecha = controllerfecha.text;
                    nuevo.numeroDocumento = controllerdocumento.text.trim();
                    nuevo.importe = double.parse(controllervalor.text.trim());
                    print(nuevo);
                    listconceptos.add(nuevo);
                    // provider.listado = listconceptos;
                    //print(provider.listado);
                    total = (double.parse(controllervalor.text) +
                            double.parse(total))
                        .toString();

                    clear();
                    if (listconceptos.length == 0) {
                      textoConceptos = "Sin Conceptos Agregados";
                    } else {
                      textoConceptos = "Conceptos Agregados";
                    }
                    setState(() {});
                  } else {}
                },
                iconSize: 20,
              ),
              IconButton(
                highlightColor: Colors.green,
                icon: Icon(Icons.send),
                iconSize: 20,
                color: Colors.white,
                onPressed: () {
                  save();
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Categoria Hijas"),
                          Container(
                            child: FutureBuilder<List<CategoriaPadre>>(
                                future: servicioCuenta.getList(
                                    widget.user.Token,
                                    widget.valor,
                                    widget.user.tipoCliente.idTipoCliente),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<CategoriaPadre>>
                                        snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return DropdownButton<CategoriaPadre>(
                                    itemHeight: 57,
                                    style: TextStyle(color: Colors.black),
                                    items: snapshot.data
                                        .map((data) =>
                                            DropdownMenuItem<CategoriaPadre>(
                                              child: Text(
                                                data.nombre,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              value: data,
                                            ))
                                        .toList(),
                                    onChanged: (CategoriaPadre value) {
                                      opcionCategoria = value.nombre;
                                      idCategoriaHija =
                                          value.idCuentaContable.toString();

                                      print(idCategoriaHija);
                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    hint: Text(
                                      opcionCategoria,
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: screenWidth * 0.80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Referencia",
                                  style: TextStyle(fontSize: 13.0),
                                ),
                                inputField(
                                    controllerref, "", TextInputType.text),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Form(
                        key: _form2Key,
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: screenWidth * 0.35,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Fecha",
                                        style: TextStyle(fontSize: 13.0),
                                      ),
                                      DateTimeField(
                                        controller: controllerfecha,
                                        validator: (value) {
                                          if (value == "") {
                                            return 'Requerido';
                                          }
                                          return null;
                                        },
                                        format: format,

                                        /*  decoration:
                                            InputDecoration(labelText: "Fecha"), */
                                        onShowPicker: (context, currentValue) {
                                          return showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ??
                                                  DateTime.now(),
                                              lastDate: DateTime(2100));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.50,

                                  //color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Medio de Pago",
                                        style: TextStyle(fontSize: 13.0),
                                      ),
                                      Container(
                                        child: FutureBuilder<
                                                List<TipoMedioPago>>(
                                            future: servicioTipoConcepto
                                                .getAll(widget.user.Token),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                        List<TipoMedioPago>>
                                                    snapshot) {
                                              if (!snapshot.hasData)
                                                return CircularProgressIndicator();
                                              return DropdownButton<
                                                  TipoMedioPago>(
                                                itemHeight: 57,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                items: snapshot.data
                                                    .map((data) =>
                                                        DropdownMenuItem<
                                                            TipoMedioPago>(
                                                          child: Text(
                                                            data.descripcion,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16),
                                                          ),
                                                          value: data,
                                                        ))
                                                    .toList(),
                                                onChanged:
                          
                                                    (TipoMedioPago value) {
                                                      
                                               /*    if (listconceptos.length==0) {
                                                    print("1");
                                                    idtipoconcepto = value
                                                        .idTipoMedioPago
                                                        .toString();
                                                    opciontipoconcepto = value
                                                        .descripcion
                                                        .toString();
                                                          setState(() {});
                                                  }else if(listconceptos.length>0){
                                                     print("2");
                                                    for (int i = 0; i < listconceptos.length; i++) {
                                                      if (listconceptos[i].idTipoConcepto == value.idTipoMedioPago){
                                                        print(listconceptos[i].idTipoConcepto);
                                                         print(value.idTipoMedioPago);
                                                        editado=false;
                                                        return;
                                                      }
                                                    }
                                                  }else if(editado==true){
                                                     print("3"); */
                                                       idtipoconcepto = value
                                                      .idTipoMedioPago
                                                      .toString();
                                                      opciontipoconcepto = value
                                                      .descripcion
                                                      .toString();
                                                      setState(() {});
                                                 /*  } */

                                                    
                                                },
                                                isExpanded: true,
                                                hint: Text(
                                                  opciontipoconcepto,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                icon:
                                                    Icon(Icons.arrow_downward),
                                                /*  value: value[],
                                                        hint: Text(""), */
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: screenWidth * 0.35,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "No. Documento",
                                        style: TextStyle(fontSize: 13.0),
                                      ),
                                      /* inputField(controllerdocumento, "",
                                          TextInputType.text), */
                                      TextField(
                                        decoration: InputDecoration(
                                            //labelText: label,
                                            /// border: InputBorder.none,
                                            ),
                                        keyboardType: TextInputType.text,

                                        controller: controllerdocumento,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (va) {},
                                        // focusNode: _local,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: Container(
                                    // width: screenWidth * 0.35,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Valor",
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                        inputField(controllervalor, "",
                                            TextInputType.number),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Visibility(
                        visible: widget.valor != "3" ? false : true,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Referencia:",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            Expanded(
                              child: FutureBuilder<List<Referencias>>(
                                  future: servicioIEP.getForRef(
                                      widget.user.Token,
                                      widget.user.idUsuario.toString()),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Referencias>>
                                          snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return DropdownButton<Referencias>(
                                      itemHeight: 50,
                                      style: TextStyle(color: Colors.black),
                                      items: snapshot.data
                                          .map((data) =>
                                              DropdownMenuItem<Referencias>(
                                                child: Text(
                                                  data.referencia,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                value: data,
                                              ))
                                          .toList(),
                                      onChanged: (Referencias value) {
                                        idReferencia = value
                                            .idOperacionFinanciera
                                            .toString();

                                        opcionReferencia = value.referencia;

                                        setState(() {});
                                      },
                                      isExpanded: true,
                                      hint: Text(
                                        opcionReferencia,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Terceros"),
                          Container(
                            child: StreamBuilder<List<Tercero>>(
                                stream: servicioTercero.popularesStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Tercero>> snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return DropdownButton<Tercero>(
                                    itemHeight: 57,
                                    style: TextStyle(color: Colors.black),
                                    items: snapshot.data
                                        .map(
                                            (data) => DropdownMenuItem<Tercero>(
                                                  child: Text(
                                                    data.nombre,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  value: data,
                                                ))
                                        .toList(),
                                    onChanged: (Tercero value) {
                                      opcionTercero = value.nombre;
                                      idTercero = value.idTercero.toString();

                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    hint: Text(
                                      opcionTercero,
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Total: "),
                          Expanded(
                            child: Container(),
                          ),
                          Text(total),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      contenedor(),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Detalleconcepto profile = listconceptos[index];
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  print(profile.idOperacionFinanciera);
                                  print(profile.idTipoConcepto);
                                  print(profile.tipoConcepto);
                                  print(profile.importe);
                                  print(profile.fecha);
                                  print(profile.numeroDocumento);
                                  print(profile);
                                },
                                child: Container(
                                  //width: MediaQuery.of(context).size.width,
                                  color: Constants.darkPrimary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          profile.tipoConcepto,
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.date_range,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        Text(
                                          profile.fecha.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Icon(
                                          Icons.monetization_on,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        Text(
                                          profile.importe.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Icon(
                                          Icons.description,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        Text(
                                          profile.numeroDocumento.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print("press");
                                            listconceptos.removeWhere((item) =>
                                                item.numeroDocumento ==
                                                profile.numeroDocumento);

                                            //provider.listado = listconceptos;
                                            //print(provider.listado);
                                            total = (double.parse(total) -
                                                    double.parse(profile.importe
                                                        .toString()))
                                                .toString();
                                            if (listconceptos.length == 0) {
                                              textoConceptos =
                                                  "Sin Conceptos Agregados";
                                            } else {
                                              textoConceptos =
                                                  "Conceptos Agregados";
                                            }
                                            setState(() {});
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 60.0,
                                              height: 25,
                                              color: Colors.blue,
                                              child: Text("Borrar",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w900,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        //napshot.data.length == null ? 0 :snapshot.data.length,
                        itemCount: listconceptos.length == null
                            ? 0
                            : listconceptos.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future dialog(screenWidth) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            // You need this, notice the parameters below:
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Tipo Identificacion:",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        Expanded(
                          child: FutureBuilder<List<TipoIdentificacion>>(
                              future: servicioTipoidentificacion
                                  .getAll(widget.user.Token),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<TipoIdentificacion>>
                                      snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return DropdownButton<TipoIdentificacion>(
                                  itemHeight: 50,
                                  style: TextStyle(color: Colors.black),
                                  items: snapshot.data
                                      .map((data) =>
                                          DropdownMenuItem<TipoIdentificacion>(
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
                                    this.setState(() {});
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Genero:",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        Expanded(
                          child: FutureBuilder<List<Genero>>(
                              future: servicioGenero.getAll(widget.user.Token),
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
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        Expanded(
                          child: FutureBuilder<List<Estrato>>(
                              future: servicioEstrato.getAll(widget.user.Token),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Estrato>> snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return DropdownButton<Estrato>(
                                  itemHeight: 50,
                                  style: TextStyle(color: Colors.black),
                                  items: snapshot.data
                                      .map((data) => DropdownMenuItem<Estrato>(
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
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        Expanded(
                          child: FutureBuilder<List<EstadoCivil>>(
                              future:
                                  servicioEstadoCivil.getAll(widget.user.Token),
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
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        Expanded(
                          child: FutureBuilder<List<Geografia>>(
                              future:
                                  servicioGeografia.getAll(widget.user.Token),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Geografia>> snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return DropdownButton<Geografia>(
                                  itemHeight: 50,
                                  style: TextStyle(color: Colors.black),
                                  items: snapshot.data
                                      .map(
                                          (data) => DropdownMenuItem<Geografia>(
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
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Expanded(
                            child: FutureBuilder<List<Departamento>>(
                                future: serviceDpto.getAll(
                                    widget.user.Token, idGeografia),
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
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Expanded(
                            child: FutureBuilder<List<Municipio>>(
                                future: serviceMunicipio.getAll(
                                    widget.user.Token, idDepartamento),
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
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Expanded(
                            child: FutureBuilder<List<Localidad>>(
                                future: serviceLocalidad.getAll(
                                    widget.user.Token, idMunicipio),
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

                                      opcionLocalidad = value.localidad;

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
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        Expanded(
                          child: Container(
                            width: screenWidth * 0.60,
                            height: 50,
                            child: inputField(
                              nombrecontroller,
                              "Nombre",
                              TextInputType.text,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Apellidos: ",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            child: inputField(apellidosController, "Apellidos",
                                TextInputType.text),
                          ),
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
                          Expanded(
                            child: Container(
                              // width: screenWidth * 0.45,
                              height: 50,
                              child: inputField(establecimientocontroller,
                                  "Establecimiento", TextInputType.text),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Email: ",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        Expanded(
                          child: Container(
                            // width: screenWidth * 0.60,
                            height: 50,
                            child: inputField(emailcontroller, "Email",
                                TextInputType.emailAddress),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Telefono: ",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        Expanded(
                          child: Container(
                            // width: screenWidth * 0.60,
                            height: 50,
                            child: inputField(
                                telefonocontroller, "Tlf", TextInputType.text),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Numero Identificacion: ",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        Expanded(
                          child: Container(
                            //width: screenWidth * 0.35,
                            height: 50,
                            child: inputField(
                                numeroController, "Numero", TextInputType.text),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Direccion: ",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        Expanded(
                          child: Container(
                            //width: screenWidth * 0.60,
                            height: 50,
                            child: inputField(direccionController, "Direccion",
                                TextInputType.text),
                          ),
                        ),
                      ],
                    ),
                    //Box para check
                    Row(
                      children: <Widget>[
                        Text("Tipo Cliente: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey)),
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
                                        widget.user.Token,
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
                                    apellidosController.text =
                                        nuevoTercero.apellido.toString().trim();
                                    emailcontroller.text =
                                        nuevoTercero.mail.toString();
                                    telefonocontroller.text =
                                        nuevoTercero.telefono.toString();
                                    direccionController.text =
                                        nuevoTercero.direccion.toString();
                                    _fechaController.text =
                                        nuevoTercero.fechaNacimiento.toString();
                                    hijosController.text =
                                        nuevoTercero.hijos.toString();

                                    idTipoIdentificacion = nuevoTercero
                                        .idTipoIdentificacion
                                        .toString();
                                    idGenero = nuevoTercero.idGenero.toString();
                                    idEstrato =
                                        nuevoTercero.idEstrato.toString();
                                    idEstadoCivil =
                                        nuevoTercero.idEstadoCivil.toString();

                                    idGeografia =
                                        nuevoTercero.idPais.toString();
                                    opcionGeografia = nuevoTercero.pais;

                                    idDepartamento =
                                        nuevoTercero.idDepartamento.toString();
                                    opcionDepartamento =
                                        nuevoTercero.departamento;

                                    idMunicipio =
                                        nuevoTercero.idMunicipio.toString();
                                    opcionMunicipio = nuevoTercero.municipio;

                                    idLocalidad =
                                        nuevoTercero.idLocalidad.toString();
                                    opcionLocalidad = nuevoTercero.localidad;

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
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        Container(
                          width: screenWidth * 0.40,
                          height: 50,
                          child: inputField(
                              hijosController, "Hijos", TextInputType.number),
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
                              builder: (context, child) {
                                return SingleChildScrollView(
                                  child: Theme(
                                    child: child,
                                    data: ThemeData.dark(),
                                  ),
                                );
                              },
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      color: Constants.darkPrimary,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PlacePicker(
                                apiKey:
                                    "AIzaSyB0l2oyv6YZpUuNCt-GofRNd14XP0q4yP8",
                                useCurrentLocation: true,
                                initialPosition:
                                    LatLng(-34.8206133, -58.4256116),
                                selectedPlaceWidgetBuilder:
                                    (context, data, state, isSearchBarFocused) {
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

                    MaterialButton(
                      onPressed: () {
                        saveTercero();
                      },
                      child: Text("Guardar Terceros",
                          style: TextStyle(color: Colors.white)),
                      color: Constants.darkPrimary,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:
                          Text("Cerrar", style: TextStyle(color: Colors.white)),
                      color: Constants.darkPrimary,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    //Text(_pickedLocation.toString()),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
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

  saveTercero() async {
    Tercero nuevo = new Tercero();

    if (_value == "Cliente") {
      //dia = "";
      establecimientocontroller.text = "";
    } else {}
    if (opcionTipoIdentificacion != "Seleccionar" &&
        opcionGenero != "Seleccionar" &&
        opcionEstrato != "Seleccionar" &&
        opcionEstadoCivil != "Seleccionar" &&
        opcionGeografia != "Seleccionar" &&
        opcionDepartamento != "Seleccionar" &&
        opcionMunicipio != "Seleccionar" &&
        opcionLocalidad != "Seleccionar" &&
        opcionTipoIdentificacion != "Seleccionar") {
      String gps = selectedPlace.geometry.location.lat.toString() +
          ";" +
          selectedPlace.geometry.location.lng.toString();
      Map data = nuevo.converCreate(
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

      var success = await servicio.create(
          widget.user.Token, data, context, 'api/Tercero/Create');
      print(success);
      if (success == "200") {
        servicioTercero.getAll(widget.user.Token);
        Navigator.pop(context);
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
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

  void clear() {
    opciontipoconcepto = "Seleccionar";
    idtipoconcepto = "0";
    controllerfecha.clear();
    controllerdocumento.clear();
    controllervalor.clear();
    // MAS CODIGO PARA ELIMINAR
  }

  Widget contenedor() {
    return Container(
        color: Constants.darkPrimary,
        width: double.infinity,
        alignment: Alignment.center,
        height: 50.0,
        child: Text(
          textoConceptos,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ));
  }

  void add() async {}

  void save() async {
    /*   if (widget.valor == "3" && opcionReferencia == "Seleccionar"){
    print("PRINT");
    return;
    }else {
      loads = new Loads(context);
      loads.toast(2, "Completa los Campos");
    }

 */
    if (_formKey.currentState.validate() &&
            //opciontipoconcepto != "Seleccionar" &&
            opcionCategoria != "Seleccionar" &&
            opcionTercero != "Seleccionar"
        //&&opcionReferencia != "Seleccionar"
        ) {
      OperacionesFinancieras item = new OperacionesFinancieras();
      item.idUsuario = widget.user.idUsuario;
      item.referencia = controllerref.text.trim();
      item.idTercero = int.parse(idTercero.toString());
      item.refIdOperacionFinanciera = idReferencia;
      item.idCategoriaPadre = int.parse(widget.valor);
      item.idCategoriaHija = int.parse(idCategoriaHija);
      item.detalleconceptos = listconceptos;

      Map data = item.toMap();

      print(data);

      var pass = await servicio.create(widget.user.Token, data, context,
          'api/OperacionesFinancieras/Create');
      if (pass == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IEP(widget.user, widget.valor)));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Completa los Campos");
    }
  }

  Widget inputField(
      TextEditingController controller, String label, TextInputType inputType) {
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
      keyboardType: inputType,

      controller: controller,
      textInputAction: TextInputAction.done,
      onChanged: (va) {},
      // focusNode: _local,
    );
  }
}
