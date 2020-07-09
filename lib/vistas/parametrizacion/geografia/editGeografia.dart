import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/geografia.dart';

import 'package:moneto2/models/user.dart';

import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/geografia/listGeografia.dart';
import 'package:moneto2/widgets/load.dart';

class EditGeografia extends StatefulWidget {
  User data_user;
  Geografia item;

  EditGeografia(this.data_user, this.item);
  @override
  _EditState createState() => new _EditState();
}

class _EditState extends State<EditGeografia>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController _descripcionController = new TextEditingController();
  ServicioParametrizacion servicio = new ServicioParametrizacion();
  Loads loads;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

   /*  _descripcionController =
        new TextEditingController(text: widget.item.descripcion); */
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.darkPrimary,
              title: Text(
                "Editar Pais",
                style: TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListGeografia(widget.data_user)));
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
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 1.1
                  : MediaQuery.of(context).size.height * 2,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  //Primera parte fecha , valor,concepto y cuenta

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                    child: Container(
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.4,
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
                                        decoration: InputDecoration(
                                            labelText: "Descripción"),
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
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        )),
                  ),
                ],
              ),
            )),
          ),
        ));
  }

  edit() async {
    if (_formKey.currentState.validate()) {
      Geografia item = new Geografia();

      Map data = item.convertMapOP(
        widget.item.idPais.toString(),
        _descripcionController.text,
      );

      await servicio.edit(widget.data_user.Token, data,
          widget.item.idPais.toString(), context, 'api/Pais/Update/');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListGeografia(widget.data_user)));
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son invalidos");
    }
  }

  delete() async {
    await servicio.delete(widget.data_user.Token, widget.item.idPais.toString(),
        context, 'api/Pais/Delete/');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListGeografia(widget.data_user)));
  }
}
