import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moneto2/models/messages/messages_create.dart';
import 'package:moneto2/models/messages/messages_detalle.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/ui_chat/list_chats.dart';
import 'package:moneto2/screens/screensHome/ui_chat/servicioChat.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/utils/servicioParametrizacion.dart';
import 'package:moneto2/widgets/load.dart';

class OpenChat extends StatefulWidget {
  User user;
  MessageDetalle detalle;
  OpenChat(this.user, this.detalle);
  @override
  _OpenChatState createState() => _OpenChatState();
}

class _OpenChatState extends State<OpenChat> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final service = new ServicioChat();
  final _formKey = GlobalKey<FormState>();
  final parametrizacion = new ServicioParametrizacion();

  int idmensaje;
  Loads loads;

  Timer _timer;

  @override
  void initState() {
    idmensaje = widget.detalle.idmensaje;
    _timer = Timer.periodic(
        Duration(seconds: 5), (timer) => service.getmessageschat(idmensaje));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkPrimary,
          title: Text(
            "Chat",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _timer?.cancel();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListChats(widget.user)));
            },
          ),
          actions: <Widget>[
            widget.user.tipoCliente.codigo == "adm"
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      delete();
                    },
                  )
                : Container(),
            /*  */
          ],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                  stream: service.popularesStream,
                  builder:
                      (context, AsyncSnapshot<List<MessageDetalle>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return _buildListView(snapshot.data);
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Material(
                        elevation: 2,
                        shape: StadiumBorder(),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Introduce el Mensaje",
                              border: InputBorder.none,
                            ),
                            controller: messageController,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Material(
                      elevation: 2.0,
                      shape: CircleBorder(),
                      color: Constants.darkPrimary,
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            MessageUser nuevo = new MessageUser();

                            //int idmensaje, int idusuario, String mensaje
                            Map data = nuevo.messageCreate(
                                widget.detalle.idmensaje,
                                widget.user.idUsuario,
                                messageController.text.trim());
                            messageController.clear();
                            await parametrizacion.create(widget.user.Token,
                                data, context, 'api/mensaje/Create_Chat');
                            service.getmessageschat(idmensaje);
                            setState(() {});

                            /*  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListChats(widget.user))); */
                          } else {
                            loads = new Loads(context);
                            loads.toast(2, "Introduce un Mensaje valido");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void delete() async {
    Map data = {
      "idmensaje": widget.detalle.idmensaje,
    };

    await parametrizacion.create(
        widget.user.Token, data, context, 'api/mensaje/cerrar_Chat');
    _timer?.cancel();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ListChats(widget.user)));
  }

  Widget _buildListView(List<MessageDetalle> list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        MessageDetalle profile = list[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            profile.nombre != "soporte"
                ? containermessage(profile.nombre, profile.mensaje, true)
                : containermessage(profile.nombre, profile.mensaje, false)
          ],
        );
      },
      itemCount: list.length,
    );
  }

  Widget containermessage(String nombre, String mensaje, bool sendByMe) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0xFF79cf6c), const Color(0xFF79cf6c)],
            )),
        child: Text(mensaje,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
