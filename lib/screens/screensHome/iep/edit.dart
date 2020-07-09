import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/categoriapadre.dart';
import 'package:moneto2/models/iep.dart';
import 'package:moneto2/models/referencias.dart';
import 'package:moneto2/models/tercero.dart';
import 'package:moneto2/models/tipomediopago.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/iep/list.dart';
import 'package:moneto2/screens/screensHome/iep/servicio.dart';
import 'package:moneto2/screens/screensHome/tercero/servicio.dart';
import 'package:moneto2/screens/screensHome/tipoconcepto/servicio.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/cuentacontable/servicio.dart';
import 'package:moneto2/widgets/load.dart';
import 'package:date_time_format/date_time_format.dart';

class EditIEP extends StatefulWidget {
  User user;
  OperacionesFinancieras item;
  String valor;

  EditIEP(this.user, this.item, this.valor);

  @override
  _EditIEPState createState() => _EditIEPState();
}

class _EditIEPState extends State<EditIEP> {
  final _formKey = GlobalKey<FormState>();
  final _form2Key = GlobalKey<FormState>();

  ServicioTipoConcepto servicioTipoConcepto = new ServicioTipoConcepto();
  ServicioTercero servicioTercero = new ServicioTercero();
  ServicioCuentaContable servicioCuenta = new ServicioCuentaContable();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  ServicioIEP servicioIEP = new ServicioIEP();
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController controllerref = new TextEditingController();
  TextEditingController controllerfecha = new TextEditingController();
  TextEditingController controllerdocumento = new TextEditingController();
  TextEditingController controllervalor = new TextEditingController();
  Loads loads;

  String total = "0";

  String opcion = "Seleccionar";
  String idtipoconcepto;

  String opcionCategoria = "Seleccionar";
  String idCategoriaHija;

  String opcionTercero = "Seleccionar";
  String idTercero;

  String opcionReferencia = "Seleccionar";
  String idReferencia = null;

  List<Detalleconcepto> listconceptos = new List<Detalleconcepto>();

  String textoConceptos = "Sin Conceptos Agregados";

  @override
  void initState() {
    super.initState();

    listconceptos = widget.item.detalleconceptos;
    opcionTercero = widget.item.tercero;
    idTercero = widget.item.idTercero.toString();
    opcionCategoria = widget.item.cuentacontablehija.toString();
    double acumulador = 0;
    for (var i = 0; i < widget.item.detalleconceptos.length; i++) {
      acumulador = acumulador +
          double.parse(widget.item.detalleconceptos[i].importe.toString());
    }
    total = acumulador.toString();
    textoConceptos = "Conceptos Agregados";
    idCategoriaHija = widget.item.idCategoriaHija.toString();
    // controllerref.text = widget.item.referencia;

    print("REFERENCIA: " + widget.item.referencia);
    print("CATEGORIA HIJA" + widget.item.idCategoriaHija.toString());
    print(widget.item.idTercero.toString());
    print(widget.item.importeTotal.toString());

    controllerref.text = widget.item.referencia;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    // final provider = Provider.of<ProviderInfo>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "Editar",
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
                icon: Icon(Icons.save),
                onPressed: () {
                  if (_form2Key.currentState.validate() &&
                      opcion != "Seleccionar") {
                    Detalleconcepto nuevo = new Detalleconcepto();
                    nuevo.idTipoConcepto = int.parse(idtipoconcepto);
                    nuevo.tipoConcepto = opcion;
                    nuevo.fecha = controllerfecha.text;
                    nuevo.numeroDocumento = controllerdocumento.text.trim();
                    nuevo.idOperacionFinanciera =0;
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
                icon: Icon(Icons.share),
                iconSize: 20,
                color: Colors.white,
                onPressed: () {
                  share();
                },
              ),
              IconButton(
                highlightColor: Colors.green,
                icon: Icon(Icons.send),
                iconSize: 20,
                color: Colors.white,
                onPressed: () {
                  save();
                },
              ),
              IconButton(
                highlightColor: Colors.green,
                icon: Icon(Icons.delete),
                iconSize: 20,
                color: Colors.white,
                onPressed: () {
                  delete();
                },
              ),

              
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
                            width: screenWidth * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Referencia",
                                  style: TextStyle(fontSize: 13.0),
                                ),
                                inputField(controllerref, "",TextInputType.text),
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
                                                  idtipoconcepto = value
                                                      .idTipoMedioPago
                                                      .toString();
                                                  opcion = value
                                                      .descripcion
                                                      .toString();

                                                  setState(() {});
                                                },
                                                isExpanded: true,
                                                hint: Text(
                                                  opcion,
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
                            child: FutureBuilder<List<Tercero>>(
                                future:
                                    servicioTercero.getAll(widget.user.Token),
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
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                print(profile.idOperacionFinanciera);
                                print(profile.idOperacionFinancieraDetalle);
                                print(profile.idTipoConcepto);
                                print(profile.tipoConcepto);
                                print(profile.importe);
                                print(format.format(DateTime.parse(profile.fecha)));
                                print(profile.numeroDocumento);
                                print(profile);
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  color: Constants.darkPrimary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          color: Colors.green,
                                          size: 25,
                                        ),
                                        Text(
                                         profile.fecha,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.monetization_on,
                                          color: Colors.green,
                                          size: 25,
                                        ),
                                        Text(
                                          profile.importe.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.description,
                                          color: Colors.green,
                                          size: 25,
                                        ),
                                        Text(
                                          profile.numeroDocumento.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print("press");
                                            listconceptos.removeWhere((item) =>
                                                item.idOperacionFinancieraDetalle ==
                                                profile.idOperacionFinancieraDetalle);

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

  void share() async {

    Map data ={
      "IdOperacionFinanciera": widget.item.idOperacionFinanciera,
    };

    print(data);
     var success = await servicio.create(
          widget.user.Token, data, context, 'api/OperacionesFinancieras/compartir');

          print(success);
  }

  void clear() {
    opcion = "Seleccionar";
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

  void delete() async {
    await servicio.delete(
        widget.user.Token,
        widget.item.idOperacionFinanciera.toString(),
        context,
        'api/OperacionesFinancieras/Delete/');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IEP(widget.user, widget.valor)));
  }

  void save() async {
      if (_formKey.currentState.validate() &&
            //opciontipoconcepto != "Seleccionar" &&
            opcionCategoria != "Seleccionar" &&
            opcionTercero != "Seleccionar"
        //&&opcionReferencia != "Seleccionar"
        ){

        
      //ACA DEBE ESTAR EL EDITAR
      OperacionesFinancieras item = new OperacionesFinancieras();
      item.idOperacionFinanciera = widget.item.idOperacionFinanciera;

      item.idUsuario = widget.user.idUsuario;
      item.referencia = controllerref.text.trim();
      item.idTercero = int.parse(idTercero.toString());
      item.refIdOperacionFinanciera = idReferencia;
      item.idCategoriaPadre = int.parse(widget.valor);
      item.idCategoriaHija = int.parse(idCategoriaHija);
      item.detalleconceptos = listconceptos;

      item.tercero = opcionTercero;

      Map data = item.toMap2();

      print(data);

      var pass = await servicio.edit(
          widget.user.Token,
          data,
          widget.item.idOperacionFinanciera.toString(),
          context,
          'api/OperacionesFinancieras/Update/');

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

  Widget inputField(TextEditingController controller, String label,TextInputType input) {
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
      keyboardType: input,

      controller: controller,
      textInputAction: TextInputAction.done,
      onChanged: (va) {},
      // focusNode: _local,
    );
  }
}
