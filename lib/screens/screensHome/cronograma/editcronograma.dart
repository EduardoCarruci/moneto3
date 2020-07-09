import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/categoriaCalendario.dart';
import 'package:moneto2/models/cronograma.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/cronograma/servicio.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/categoriaCalendario/servicio.dart';
import 'package:moneto2/widgets/load.dart';

import 'listCronograma.dart';

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
  //final format = DateFormat("dd/MM/yyyy");
   final format = DateFormat("yyyy-MM-dd");
   //final formato =  DateFormat('yMd');
  TextEditingController _fechaController = new TextEditingController();
  TextEditingController actividadController = new TextEditingController();
  TextEditingController controllerfecha = new TextEditingController();
  ServicioCronograma servicioCronograma = new ServicioCronograma();
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
  String idUsuario;

  String opcionAlarma = "Seleccionar";

  List<CategoriaCalendario> listcategoria;
  @override
  void initState() {
    print(widget.item.fechafinalizacion);
    WidgetsBinding.instance.addObserver(this);
    idCategoriaCalendario = widget.item.idCategoria.toString();
    _valorSemana = widget.item.recurrencia;
    idRecurrencia = widget.item.idRecurrencia;
    dia = widget.item.dia;
    diaLargo = widget.item.dialargo;
    controllerfecha.text =
        format.format(DateTime.parse(widget.item.fechafinalizacion.toString()));
    //controllerfecha.text = widget.item.fechafinalizacion.toString();

    valorChar = dia;

    print(dia);
    print(diaLargo);

    print(valorChar);
    if (valorChar == "") {
      valorChar = "L";
    }

    if (widget.item.idRecurrencia == 1) {
      showComboDay = true;
      showFecha = true;
    } else {
      showComboDay = false;
      showFecha = true;
    }
    _fechaController.text = format.format(DateTime.parse(widget.item.fecha.toString()));
    //var date = new DateFormat("yyyy-MM-dd").parse((widget.item.fecha.toString()));
    //print(date.toString());

 
    //_fechaController.text = widget.item.fecha;
    actividadController.text = widget.item.actividad;
    opcionCategoriaCalendario = widget.item.categoria;
    //opcionAlarma = widget.item.
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
                "Editar Cronograma",
                style: TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListCronograma(widget.data_user)));
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
                                    showFecha = true;
                                    showComboDay = true;
                                  } else {
                                    showFecha = true;
                                    showComboDay = false;
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
                                    return DropdownButton<CategoriaCalendario>(
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
                                        opcionCategoriaCalendario = value.nombre;
                                        setState(() {});
                                      },
                                      isExpanded: true,
                                      hint: Text(
                                        opcionCategoriaCalendario,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      icon: Icon(Icons.arrow_drop_down),
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
                          decoration:
                              InputDecoration(labelText: "Fecha Inicio"),
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
                        height: 0.0,
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
                        decoration: InputDecoration(labelText: "Fecha Fin"),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              helpText: "Escoge un día",
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                      SizedBox(
                        height: 10.0,
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
                      /* SizedBox(
                        height: 5.0,
                      ), */
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Alarmas: ",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Expanded(
                            child: Container(
                              child: FutureBuilder<List<Cronograma>>(
                                  future: servicioCronograma.getAlarmas(
                                      widget.data_user.Token,
                                      widget.item.idCronograma.toString()),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Cronograma>>
                                          snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return _buildListView(snapshot.data);
                                  }),
                            ),
                          )
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

  Widget _buildListView(List<Cronograma> list) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Cronograma profile = list[index];
        return Card(
          child: Center(
            child: Text(
              format.format(DateTime.parse(profile.fecha.toString())),
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        );
      },
      itemCount: list.length,
    );
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
    if (_formKey.currentState.validate() &&
        opcionCategoriaCalendario != "Seleccionar" &&
        controllerfecha.text != null &&
        _fechaController != null) {
      Cronograma nuevo = new Cronograma();

      print("Hola: " + _fechaController.text.toString().trim());

      if (_valorSemana == "Semanal") {
        //dia = "";
        //_fechaController.text = "";
      } else {
        valorChar = "";
      }

      Map data = nuevo.convertMapOP(
          widget.item.idCronograma,
          _fechaController.text.toString().trim(),
          actividadController.text.trim(),
          1,
          idCategoriaCalendario,
          idRecurrencia.toString(),
          valorChar,
          widget.data_user.idUsuario.toString(),
          controllerfecha.text);

      print("DATA: " + data.toString());
      var item = await servicio.edit(
          widget.data_user.Token,
          data,
          widget.item.idCronograma.toString(),
          context,
          'api/Cronograma/Update/');
      if (item == "200") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListCronograma(widget.data_user)));
      }
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
    //al servicio
  }

  delete() async {
    await servicio.delete(widget.data_user.Token,
        widget.item.idCronograma.toString(), context, "api/Cronograma/Delete/");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListCronograma(widget.data_user)));
  }
}
