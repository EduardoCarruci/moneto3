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

class CreateCronograma extends StatefulWidget {
  User data_user;
  CreateCronograma(this.data_user);
  @override
  _Crear createState() => new _Crear();
}

class _Crear extends State<CreateCronograma>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _fechaController = new TextEditingController();
  TextEditingController actividadController = new TextEditingController();

  ServicioParametrizacion servicio = new ServicioParametrizacion();
  ServicioCategoriaCalendario servicioCalendario = new ServicioCategoriaCalendario();

  String opcionCategoria = "Seleccionar";
  String idCategoria;
  DateTime selectedDate = DateTime.now();
  int selectDay = 0;
  String dia = "L";
  String _value = "Semanal";
  String dropdownValue = 'Lunes';

  bool showFecha = false;
  bool showComboDay = true;
  String valorChar = "L";
  Loads loads;
  int idRecurrencia = 1;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

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
                  "Añadir Nuevo Cronograma",
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
                    icon: Icon(Icons.save),
                    onPressed: () {
                      save();
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
                                    _value = value;
                                    print(_value);
                                    switchRecurencia(value);
                                    if (value == "Semanal") {
                                      showFecha = false;
                                      showComboDay = true;
                                    } else {
                                      showFecha = true;
                                      showComboDay = false;
                                    }
                                    setState(() {});
                                    print("Id Recurrencia: " +
                                        idRecurrencia.toString());
                                  },
                                  hint: Text(_value),
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
                                    future: servicioCalendario
                                        .getAll(widget.data_user.Token),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<CategoriaCalendario>>
                                            snapshot) {
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
                                      return DropdownButton<CategoriaCalendario>(
                                        itemHeight: 50,
                                        style: TextStyle(color: Colors.black),
                                        items: snapshot.data
                                            .map((data) =>
                                                DropdownMenuItem<CategoriaCalendario>(
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
                                          idCategoria = value.idCategoriaCalendario.toString();
                                          print(value.idCategoriaCalendario.toString());
                                          print(value.nombre);
                                          opcionCategoria = value.nombre;
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
                        Visibility(
                          visible: showComboDay,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: [
                              DropdownMenuItem<String>(
                                child: Text('Lunes'),
                                value: 'L',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Martes'),
                                value: 'M',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Miercoles'),
                                value: 'X',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Jueves'),
                                value: 'J',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Viernes'),
                                value: 'V',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Sabado'),
                                value: 'S',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Domingo'),
                                value: 'D',
                              ),
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

  Future<Null> _selectDate(BuildContext context) async {
    showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
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

  save() async {
    if (_formKey.currentState.validate()) {
      Cronograma nuevo = new Cronograma();

      print("Hola: " + _fechaController.text.toString().trim());

      if (_value == "Semanal") {
        //dia = "";
        _fechaController.text = "";
      } else {
        valorChar = "";
      }

     
      Map data = nuevo.convertMap(
          _fechaController.text.toString().trim(),
          actividadController.text.trim(),
          1,
          idCategoria.toString(),
          idRecurrencia.toString(),
          valorChar);

      print("DATA: " + data.toString());
      //al servicio
      await servicio.create(
          widget.data_user.Token, data, context, 'api/Cronograma/Create'); 
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
