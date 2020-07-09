import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneto2/models/messages/messages_create.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

import 'list_chats.dart';

class CreateChatUser extends StatefulWidget {
  User user;
  CreateChatUser(this.user);
  @override
  _createState createState() => new _createState();
}

class _createState extends State<CreateChatUser>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {

  TextEditingController titulocontroller = new TextEditingController();

  TextEditingController mensajecontroller = new TextEditingController();

  Loads loads;
  ServicioParametrizacion servicio = new ServicioParametrizacion();

  final _formKey = GlobalKey<FormState>();

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
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.darkPrimary,
            title: Text(
              "Crear Chat",
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ListChats(widget.user)));
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
              child: Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
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
                            decoration: InputDecoration(labelText: "Titulo"),
                            keyboardType: TextInputType.text,

                            controller: titulocontroller,
                            textInputAction: TextInputAction.next,
                            onChanged: (va) {},
                            // focusNode: _local,
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Mensaje"),
                            keyboardType: TextInputType.text,

                            controller: mensajecontroller,
                            textInputAction: TextInputAction.next,
                            onChanged: (va) {},
                            // focusNode: _local,
                          ),
                          flex: 3,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ))),
        ));
  }

  save() async {
    if (_formKey.currentState.validate()) {
        MessageUser nuevo = new MessageUser();
        //int idusuario, String titulo, String mensajeinicial

        print(widget.user.idUsuario);
      Map data =
          nuevo.convertMap(widget.user.idUsuario,titulocontroller.text.trim(),mensajecontroller.text.trim());

      var v = await servicio.create(
          widget.user.Token, data, context, 'api/Mensaje/Create');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListChats(widget.user)));
    } else {
      loads = new Loads(context);
      loads.toast(2, "Los campos son Invalidos");
    }
  }
}
