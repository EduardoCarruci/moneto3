import 'package:flutter/material.dart';
import 'package:moneto2/models/seguridad.dart';
import 'package:moneto2/models/tipoCliente.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/vistas/parametrizacion/seguridad/listseguridad.dart';
import 'package:moneto2/vistas/parametrizacion/seguridad/servicio.dart';
import 'package:moneto2/widgets/load.dart';

class EditSeguridad extends StatefulWidget {
  User data_user;

  TipoCliente item;

  EditSeguridad(this.data_user, this.item);
  @override
  _EditSeguridadState createState() => _EditSeguridadState();
}

class _EditSeguridadState extends State<EditSeguridad> {
  final _formKey = GlobalKey<FormState>();
  List<Seguridad> _list;
  ServicioSeguridad servicio = new ServicioSeguridad();
  ServicioParametrizacion service = new ServicioParametrizacion();

  Loads loads;

  List<bool> listbanderas = new List<bool>(8);
  bool banderaIngresos = true;
  bool banderaEgresos = true;
  bool banderaPresupuesto = true;
  bool banderaCronograma = true;
  bool banderaAlarmas = true;
  bool banderaParametrizacion = true;
  bool banderaHerramientas = true;
  bool banderaTerceros = true;

  int pivoteIngresos = 1;
  int pivoteEgresos = 1;
  int pivotePresupuesto = 1;
  int pivoteCronograma = 1;
  int pivoteAlarmas = 1;
  int pivoteParametrizacion = 1;
  int pivoteHerramientas = 1;
  int pivoteTerceros = 1;

  @override
  void initState() {
    //print(widget.item.idTipoCliente);
    getListElements();

    super.initState();
  }

  Future<void> getListElements() async {
    _list = await servicio.getAllHijos(
        widget.data_user.Token, widget.item.idTipoCliente.toString());

    print(_list[0].idhabilitado);
    print(_list[1].idhabilitado);
    print(_list[2].idhabilitado);
    print(_list[3].idhabilitado);
    print(_list[4].idhabilitado);
    print(_list[5].idhabilitado);
    print(_list[6].idhabilitado);
    print(_list[7].idhabilitado);

    for (int i = 0; i < _list.length; i++) {
      if (_list[i].idhabilitado == 1) {
        listbanderas[i] = true;
        print(listbanderas[i]);
      } else if (_list[i].idhabilitado == 0) {
        listbanderas[i] = false;
        print(listbanderas[i]);
      }
    }
    print("\n");
    print("\n");
    print(listbanderas);
    banderaIngresos = listbanderas[0];
    banderaEgresos = listbanderas[1];
    banderaPresupuesto = listbanderas[2];
    banderaCronograma = listbanderas[3];
    banderaAlarmas = listbanderas[4];
    banderaParametrizacion = listbanderas[5];
    banderaHerramientas = listbanderas[6];
    banderaTerceros = listbanderas[7];
/* 
    print("\n");
    print("\n");
    print(banderaIngresos);
    print(banderaEgresos);
    print(banderaPresupuesto);
    print(banderaCronograma);
    print(banderaAlarmas);
    print(banderaParametrizacion);
    print(banderaHerramientas);
    print(banderaTerceros); */

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.darkPrimary,
              title: Text(
                "Editar Seguridad",
                style: TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListSeguridad(widget.data_user)));
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
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Ingresos",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Checkbox(
                                  value: banderaIngresos,
                                  onChanged: (newValue) {
                                    banderaIngresos = newValue;

                                    setState(() {});
                                  },
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Egresos",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Checkbox(
                                  value: banderaEgresos,
                                  onChanged: (newValue) {
                                    banderaEgresos = newValue;

                                    setState(() {});
                                  },
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Presupuesto",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Checkbox(
                                  value: banderaPresupuesto,
                                  onChanged: (newValue) {
                                    banderaPresupuesto = newValue;

                                    setState(() {});
                                  },
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Cronograma",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Checkbox(
                                  value: banderaCronograma,
                                  onChanged: (newValue) {
                                    banderaCronograma = newValue;

                                    setState(() {});
                                  },
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Alarmas",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Checkbox(
                                  value: banderaAlarmas,
                                  onChanged: (newValue) {
                                    banderaAlarmas = newValue;

                                    setState(() {});
                                  },
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Parametrizacion",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Checkbox(
                                  value: banderaParametrizacion,
                                  onChanged: (newValue) {
                                    banderaParametrizacion = newValue;

                                    setState(() {});
                                  },
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Herramientas",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Checkbox(
                                  value: banderaHerramientas,
                                  onChanged: (newValue) {
                                    banderaHerramientas = newValue;

                                    setState(() {});
                                  },
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Terceros",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Checkbox(
                                  value: banderaTerceros,
                                  onChanged: (newValue) {
                                    banderaTerceros = newValue;

                                    setState(() {});
                                  },
                                ),
                              ]),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  edit() async {
    print("\n");
    print("\n");
    print(banderaIngresos);

    print(banderaEgresos);

    print(banderaPresupuesto);

    print(banderaCronograma);

    print(banderaAlarmas);

    print(banderaParametrizacion);

    print(banderaHerramientas);

    print(banderaTerceros);

    if (banderaIngresos) {
      pivoteIngresos = 1;
    } else {
      pivoteIngresos = 0;
    }

    if (banderaEgresos) {
      pivoteEgresos = 1;
    } else {
      pivoteEgresos = 0;
    }

    if (banderaPresupuesto) {
      pivotePresupuesto = 1;
    } else {
      pivotePresupuesto = 0;
    }

    if (banderaCronograma) {
      pivoteCronograma = 1;
    } else {
      pivoteCronograma = 0;
    }

    if (banderaAlarmas) {
      pivoteAlarmas = 1;
    } else {
      pivoteAlarmas = 0;
    }

    if (banderaParametrizacion) {
      pivoteParametrizacion = 1;
    } else {
      pivoteParametrizacion = 0;
    }

    if (banderaHerramientas) {
      pivoteHerramientas = 1;
    } else {
      pivoteHerramientas = 0;
    }

    if (banderaTerceros) {
      pivoteTerceros = 1;
    } else {
      pivoteTerceros = 0;
    }

    List<Map<dynamic, dynamic>> lista = new List<Map<dynamic, dynamic>>();
    lista.add({
      "IdTipoClienteMenu": _list[0].IdTipoClienteMenu,
      "idhabilitado": pivoteIngresos
    });
    lista.add({
      "IdTipoClienteMenu": _list[1].IdTipoClienteMenu,
      "idhabilitado": pivoteEgresos
    });
    lista.add({
      "IdTipoClienteMenu": _list[2].IdTipoClienteMenu,
      "idhabilitado": pivotePresupuesto
    });
    lista.add({
      "IdTipoClienteMenu": _list[3].IdTipoClienteMenu,
      "idhabilitado": pivoteCronograma
    });
    lista.add({
      "IdTipoClienteMenu": _list[4].IdTipoClienteMenu,
      "idhabilitado": pivoteAlarmas
    });
    lista.add({
      "IdTipoClienteMenu": _list[5].IdTipoClienteMenu,
      "idhabilitado": pivoteParametrizacion
    });
    lista.add({
      "IdTipoClienteMenu": _list[6].IdTipoClienteMenu,
      "idhabilitado": pivoteHerramientas
    });
    lista.add({
      "IdTipoClienteMenu": _list[7].IdTipoClienteMenu,
      "idhabilitado": pivoteTerceros
    });
    print("\n");
    print("\n");
    print(lista);

    await service.editAvanzado(
        widget.data_user.Token, lista, context, 'api/Seguridad/Update');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListSeguridad(widget.data_user)));
  }

  delete() async {}
}
