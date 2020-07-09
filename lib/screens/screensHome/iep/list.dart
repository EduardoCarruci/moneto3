import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneto2/models/iep.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/iep/edit.dart';
import 'package:moneto2/screens/screensHome/iep/servicio.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/principales/home.dart';
import 'package:moneto2/vistas/principales/parametizacion.dart';

import 'create.dart';

class IEP extends StatefulWidget {
  User user;
  String valor;

  IEP(this.user, this.valor);
  @override
  _IEPState createState() => _IEPState();
}

class _IEPState extends State<IEP> {
  ServicioIEP servicio = new ServicioIEP();
  final format = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    //print(widget.valor.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Constants.darkPrimary,
          title: Text(
            "Listados",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home(widget.user)));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateList(widget.user, widget.valor)));
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: servicio.getAll(widget.user.Token, widget.valor,
              widget.user.idUsuario.toString()),
          builder: (BuildContext context,
              AsyncSnapshot<List<OperacionesFinancieras>> snapshot) {
            if (snapshot.hasData) {
              return _buildListView(snapshot.data);
            } else {
              return Center(
                //ACA DEBERIA ESTAR EL EVENTO DE CARGAR LAS IMAGENES
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )),
    );
  }

  Widget _buildListView(List<OperacionesFinancieras> list) {
    int value;
    if (list == null || list.length == 0) {
      value = null;
    } else {
      //value = int.parse(list.detalleconceptos.length.toString());
      for (var i = 0; i < list.length; i++) {
        //  print(i);
      }
      value = list.length;
      //  print(value);
    }

    /* if (value == null || value == 0){
      value =1;
    } */

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          OperacionesFinancieras profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                OperacionesFinancieras item = new OperacionesFinancieras();
                item.detalleconceptos = list[index].detalleconceptos;
                item.idOperacionFinanciera = list[index].idOperacionFinanciera;
                item.idUsuario = list[index].idUsuario;
                item.referencia = list[index].referencia;
                item.importeTotal = list[index].importeTotal;
                item.idTercero = list[index].idTercero;
                item.tercero = list[index].tercero;
                item.refIdOperacionFinanciera =
                    list[index].refIdOperacionFinanciera;
                item.idCategoriaPadre = list[index].idCategoriaPadre;
                item.cuentacontablehija = list[index].cuentacontablehija;
                item.idCategoriaHija = list[index].idCategoriaHija;
              
                for (int i = 0; i < item.detalleconceptos.length; i++) {
                  print(item.detalleconceptos[i].fecha);
                  String day = item.detalleconceptos[i].fecha.split('/')[0];
                  if ( day.length ==1){
                    day =  "0" + day;
                  }
                  String month = item.detalleconceptos[i].fecha.split('/')[1];
                  if ( month.length ==1){
                    month =  "0" + month;
                  }
                  String year = item.detalleconceptos[i].fecha.split('/')[2];

                  print(year + month + day);
                  String dateParse = year +"-"+ month +"-"+ day;
                  print("DATEPARSE: "+dateParse);

                  item.detalleconceptos[i].fecha = dateParse;
                  /*    item.detalleconceptos[i].fecha = formatter
                      .format(DateTime.parse(item.detalleconceptos[i].fecha)); */
                }

                for (int i = 0; i < item.detalleconceptos.length; i++) {
                  print(item.detalleconceptos[i].fecha);
                }

                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditIEP(widget.user, item,widget.valor))); 
              },
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.attach_money,
                        color: Colors.green,
                        size: 25,
                      ),
                      Text(
                        profile.referencia.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "(" + profile.importeTotal.toString() + ")",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        //napshot.data.length == null ? 0 :snapshot.data.length,
        itemCount: value == null ? 0 : value,
      ),
    );
  }
}
