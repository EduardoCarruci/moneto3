import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/idiomas.dart';
import 'package:moneto2/models/periodicidad.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

class EditIdioma extends StatefulWidget {
  User data_user;
  Idioma idioma;
  EditIdioma(this.data_user, this.idioma);
  @override
  _EditState createState() => new _EditState();
}

class _EditState extends State<EditIdioma>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _descripcionController  = new TextEditingController();
  TextEditingController _nombreCampoController  = new TextEditingController();
  TextEditingController _equivalenciaController = new TextEditingController();

  ServicioParametrizacion servicio = new ServicioParametrizacion();

  final _formKey = GlobalKey<FormState>();

  Loads loads;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _equivalenciaController = new TextEditingController(
        text: widget.idioma.equivalencia.toString());
    _nombreCampoController =
        new TextEditingController(text: widget.idioma.nombreCampo);
    _descripcionController =
        new TextEditingController(text: widget.idioma.descripcion);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Moneto2",
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
                  "Editar Idioma",
                  style: TextStyle(fontSize: 18),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                   Navigator.pop(context);
                  },
                ),
                titleSpacing: 0,
                //centerTitle: true,
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
                  child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.5
                        : MediaQuery.of(context).size.height * 2,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Requerido';
                                  }
                                  return null;
                                },
                                  

                                decoration:
                                    InputDecoration(labelText: "Descripcion"),
                                keyboardType: TextInputType.text,

                                controller: _descripcionController,
                                textInputAction: TextInputAction.next,
                                onChanged: (va) {},
                                // focusNode: _local,
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Requerido';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: "Nombre Campo"),
                                keyboardType: TextInputType.text,

                                controller: _nombreCampoController,
                                textInputAction: TextInputAction.next,
                                onChanged: (va) {},
                                // focusNode: _local,
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Requerido';
                                  }
                                  return null;
                                },
                                  
 
                                decoration:
                                    InputDecoration(labelText: "Equivalencia"),
                                keyboardType: TextInputType.text,

                                controller: _equivalenciaController,
                                textInputAction: TextInputAction.done,
                                onChanged: (va) {},
                                // focusNode: _local,
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              )),
            ),
          ),
        ));
  }

  edit() async {
    if (_formKey.currentState.validate()) {
      Idioma item = new Idioma();

      Map data = item.convertMapOP(
          widget.idioma.idIdioma.toString(),
           _descripcionController .text,
          _nombreCampoController .text,
        
         
         _equivalenciaController.text);

      await servicio.edit(widget.data_user.Token, data,
          widget.idioma.idIdioma.toString(), context,'api/Idioma/Update/');


    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
   if (_formKey.currentState.validate()) {
      Periodicidad item = new Periodicidad();
 Map data = item.convertMapOP(
          widget.idioma.idIdioma.toString(),
         _descripcionController .text,
         _nombreCampoController .text,
         _equivalenciaController.text);

      await servicio.delete(widget.data_user.Token, data,
          widget.idioma.idIdioma.toString(), context,'api/Idioma/Delete/');


    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }
}
