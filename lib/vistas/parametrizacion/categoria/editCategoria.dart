import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:moneto2/models/categoria.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/categoria/servicio.dart';
import 'package:moneto2/widgets/load.dart';

class EditCategoria extends StatefulWidget {
  User user;
  Categoria categoria;

  EditCategoria(this.user, this.categoria);
  @override
  _EditCategoriaState createState() => new _EditCategoriaState();
}

class _EditCategoriaState extends State<EditCategoria> {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _NombreController = new TextEditingController();
 /*  TextEditingController _PonderacionController = new TextEditingController(); */
  TextEditingController _codigoController = new TextEditingController();

 /*  TextEditingController _subnivelController = new TextEditingController(); */

  final _formKey = GlobalKey<FormState>();
  Loads loads;

  ServicioParametrizacion servicio = new ServicioParametrizacion();
  @override
  void initState() {
    super.initState();

    print(widget.categoria.nombre);
    /* print(widget.categoria.ponderar); */
    print(widget.categoria.codigo);
  /*   print(widget.categoria.subnivel); */

    _NombreController =
        new TextEditingController(text: widget.categoria.nombre);
        _codigoController =
        new TextEditingController(text: widget.categoria.codigo);
    /* _PonderacionController =
        new TextEditingController(text: widget.categoria.ponderar.toString()); */
    /* _PonderacionController =
        new TextEditingController(text: widget.categoria.codigo.toString()); */
   /*  _subnivelController =
        new TextEditingController(text: widget.categoria.subnivel.toString()); */
    //FATALN DOS MAS
  }

  @override
  Widget build(BuildContext context) {
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
                  "Editar Categoría",
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
                      update();
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
                  child: Container(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.25
                          : MediaQuery.of(context).size.height * 2,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
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
                                    InputDecoration(labelText: "Nombre"),
                                keyboardType: TextInputType.text,

                                controller: _NombreController,
                                textInputAction: TextInputAction.next,
                                onChanged: (va) {},

                                // focusNode: _local,
                              ),
                              flex: 2,
                            ),
                         
                            Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(labelText: "Codigo"),
                                  keyboardType: TextInputType.text,

                                  controller: _codigoController,
                                  textInputAction: TextInputAction.next,

                                  // focusNode: _local,
                                ),
                                flex: 2),
                         
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ))),
            ),
          ),
        ));
  }

  delete() async {
    if (_formKey.currentState.validate()) {
      Categoria item = new Categoria();

      Map data = item.convertMapOP(
        widget.categoria.id,
        _codigoController.text,
        _NombreController.text,
       // _subnivelController.text,
      //  _PonderacionController.text,
      );

      await servicio.delete(widget.user.Token, data,
          widget.categoria.id.toString(), context, 'api/Categorias/Delete/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  update() async {
    if (_formKey.currentState.validate()) {
      Categoria item = new Categoria();

      Map data = item.convertMapOP(
        widget.categoria.id,
        _codigoController.text,
        _NombreController.text,
       // _subnivelController.text,
      //  _PonderacionController.text,
      );

      await servicio.edit(widget.user.Token, data,
          widget.categoria.id.toString(), context, 'api/Categorias/Update/');
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }
}
