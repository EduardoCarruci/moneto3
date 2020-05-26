import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/categoria.dart';
import 'package:moneto2/models/categoriaCalendario.dart';
import 'package:moneto2/models/cronograma.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/categoria/servicio.dart';
import 'package:moneto2/vistas/parametrizacion/categoriaCalendario/servicio.dart';
import 'package:moneto2/widgets/load.dart';

class EditCronograma extends StatefulWidget {
  User data_user;
  Cronograma item;

  EditCronograma(this.data_user, this.item);
  @override
  _Crear createState() => new _Crear();
}

class _Crear extends State<EditCronograma>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _fechaController = new TextEditingController();
  TextEditingController actividadController = new TextEditingController();

  ServicioParametrizacion servicio = new ServicioParametrizacion();
  ServicioCategoriaCalendario servicioCategoria =
      new ServicioCategoriaCalendario();

  String opcionCategoriaCalendario = "Seleccionar";
  String idCategoriaCalendario;
  DateTime selectedDate = DateTime.now();
  int selectDay = 0;
  String dia;
  String diaLargo;
  String _valorSemana = "Semanal";

  bool showFecha;
  bool showComboDay;
  String valorChar = "L";
  Loads loads;
  int idRecurrencia = 1;

  List<CategoriaCalendario> listcategoria;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    idCategoriaCalendario = widget.item.idCategoria.toString();
    _valorSemana = widget.item.recurrencia;
    idRecurrencia = widget.item.idRecurrencia;
    dia = widget.item.dia;
    diaLargo = widget.item.dialargo;
    opcionCategoriaCalendario = widget.item.categoria;
    valorChar = dia;

    print(dia);
    print(diaLargo);

    print(valorChar);
    if (valorChar == "") {
      valorChar = "L";
    }

    if (widget.item.idRecurrencia == 1) {
      showComboDay = true;
      showFecha = false;
    } else {
      showComboDay = false;
      showFecha = true;
    }
    _fechaController.text = widget.item.fecha;
    actividadController.text = widget.item.actividad;

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

    return MaterialApp(
        title: "Moneto",
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, cursorColor: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Constants.darkPrimary,
                title: Text(
                  "Editar Cronograma",
                  style: TextStyle(fontSize: 18),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
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
                    icon: Icon(Icons.clear),
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
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: width,
                          //color: Colors.red,
                          child: inputField(actividadController, "Actividad"),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Recurrencia  ",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey)),
                            Expanded(
                              child: Container(
                                child: DropdownButton<String>(
                                  items: [
                                    options("Semanal", "Semanal"),
                                    options("Quincenal", "Quincenal"),
                                    options("Mensual", "Mensual"),
                                    options("Bimestral", "Bimestral"),
                                    options("Trimestral", "Trimestral"),
                                    options("Semestral", "Semestral"),
                                  ],
                                  isExpanded: true,
                                  onChanged: (String value) {
                                    _valorSemana = value;
                                    print(_valorSemana);
                                    switchRecurencia(value);
                                    if (value == "Semanal") {
                                      showFecha = false;
                                    } else {
                                      showFecha = true;
                                    }
                                    setState(() {});
                                    print("Id Recurrencia: " +
                                        idRecurrencia.toString());
                                  },
                                  hint: Text(_valorSemana),
                                ),
                              ),
                            )
                          ],
                        ),
                        /*  
                         */

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Categorias: ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Expanded(
                              child: Container(
                                child: FutureBuilder<List<CategoriaCalendario>>(
                                    future: servicioCategoria
                                        .getAll(widget.data_user.Token),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<CategoriaCalendario>>
                                            snapshot) {
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
                                      return DropdownButton<
                                          CategoriaCalendario>(
                                        itemHeight: 50,
                                        style: TextStyle(color: Colors.black),
                                        items: snapshot.data
                                            .map((data) => DropdownMenuItem<
                                                    CategoriaCalendario>(
                                                  child: Text(
                                                    data.nombre,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  value: data,
                                                ))
                                            .toList(),
                                        onChanged: (CategoriaCalendario value) {
                                          idCategoriaCalendario = value
                                              .idCategoriaCalendario
                                              .toString();
                                          print(value.idCategoriaCalendario
                                              .toString());
                                          print(value.nombre);
                                          idCategoriaCalendario = value.nombre;
                                          setState(() {});
                                        },
                                        isExpanded: true,
                                        hint: Text(
                                          opcionCategoriaCalendario,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        icon: Icon(Icons.arrow_downward),
                                        /*  value: value[],
                                                  hint: Text(""), */
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                        Visibility(
                          visible: showFecha,
                          child: DateTimeField(
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
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: showComboDay,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: [
                              options("Lunes", "L"),
                              options("Martes", "M"),
                              options("Miercoles", "X"),
                              options("Jueves", "J"),
                              options("Viernes", "V"),
                              options("Sabado", "S"),
                              options("Domingo", "D"),
                            ],
                            onChanged: (String change) {
                              valorChar = change;
                              selectionday(valorChar);
                              print(dia);
                              setState(() {});
                            },
                            value: valorChar,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void switchRecurencia(String recurrencia) {
    switch (recurrencia) {
      case "Semanal":
        idRecurrencia = 1;
        break;
      case "Quincenal":
        idRecurrencia = 2;
        break;
      case "Mensual":
        idRecurrencia = 3;
        break;
      case "Bimestral":
        idRecurrencia = 4;
        break;
      case "Trimestral":
        idRecurrencia = 5;
        break;
      case "Semestral":
        idRecurrencia = 6;
        break;

      default:
        break;
    }
  }

/*   void switchRecurenciaInicial(int recurrencia) {
    switch (recurrencia) {
      case 1:
        _value = "Semanal";
        break;
      case 2:
        _value = "Quincenal";
        break;
      case 3:
        _value = "Mensual";
        break;
      case 4:
        _value = "Bimestral";
        break;
      case 5:
        _value = "Trimestral";
        break;
      case 6:
        _value = "Semestral";
        break;

      default:
        break;
    }
  } */

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

  void selectionday(String change) {
    switch (change) {
      case "Lunes":
        dia = "L";
        break;
      case "Martes":
        dia = "M";

        break;
      case "Miercoles":
        dia = "M";

        break;
      case "Jueves":
        dia = "J";

        break;
      case "Viernes":
        dia = "V";

        break;
      case "Sabado":
        dia = "S";

        break;
      case "Domingo":
        dia = "D";

        break;

      default:
        break;
    }
  }

  void selectionSwitchDay(String valorChar) {
    switch (valorChar) {
      case "L":
        valorChar = "Lunes";
        break;
      case "M":
        valorChar = "Martes";
        setState(() {});

        break;
      case "X":
        valorChar = "Miercoles";

        break;
      case "J":
        valorChar = "Jueves";

        break;
      case "V":
        valorChar = "Viernes";

        break;
      case "S":
        valorChar = "Sabado";

        break;
      case "D":
        valorChar = "Domingo";

        break;

      default:
        break;
    }
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
        labelText: label,
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,

      controller: controller,
      textInputAction: TextInputAction.done,
      onChanged: (va) {},
      // focusNode: _local,
    );
  }

  edit() async {
    if (_formKey.currentState.validate()) {
      Cronograma nuevo = new Cronograma();

      print("Hola: " + _fechaController.text.toString().trim());

      if (_valorSemana == "Semanal") {
        //dia = "";
        _fechaController.text = "";
      } else {
        valorChar = "";
      }
/*
int idCronograma, String fecha, String actividad, int idAlarma,
      int idCategoria, int idRecurrencia, String dia */
      Map data = nuevo.convertMapOP(
          widget.item.idCronograma,
          _fechaController.text.toString().trim(),
          actividadController.text.trim(),
          1,
          idCategoriaCalendario,
          idRecurrencia.toString(),
          valorChar);

      print("DATA: " + data.toString());
      await servicio.edit(
          widget.data_user.Token,
          data,
          widget.item.idCronograma.toString(),
          context,
          'api/Cronograma/Update/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
    //al servicio
  }

  delete() async {
    if (_formKey.currentState.validate()) {
      Cronograma nuevo = new Cronograma();

      Map data = nuevo.convertMap(
          _fechaController.text.toString().trim(),
          actividadController.text.trim(),
          1,
          idCategoriaCalendario.toString(),
          idRecurrencia.toString(),
          valorChar);

      await servicio.delete(
          widget.data_user.Token,
          data,
          widget.item.idCronograma.toString(),
          context,
          "api/Cronograma/Delete/");
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }
}
