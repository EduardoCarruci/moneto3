import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moneto2/models/messages/messages_admin.dart';
import 'package:moneto2/models/messages/messages_create.dart';
import 'package:moneto2/models/messages/messages_detalle.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/screens/screensHome/ui_chat/chat.dart';
import 'package:moneto2/screens/screensHome/ui_chat/servicioadm.dart';
import 'package:moneto2/screens/screensHome/ui_chat/serviciouser.dart';
import 'package:moneto2/utils/Const.dart';
import 'package:moneto2/vistas/principales/home.dart';

import 'create.dart';

class ListChats extends StatefulWidget {
  User user;
  ListChats(this.user);

  @override
  _ListChatsState createState() => _ListChatsState();
}

class _ListChatsState extends State<ListChats> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final messagesadm = new ServiceMessagesAdm();
  final messagesuser = new ServicioMessagesUser();
  Timer _timer;

  @override
  void initState() {
    //Check the server every 5 seconds
    if (widget.user.tipoCliente.codigo == "adm") {
      _timer = Timer.periodic(
          Duration(seconds: 5), (timer) => messagesadm.getMessagesAdm());
    } else {
      _timer = Timer.periodic(Duration(seconds: 5),
          (timer) => messagesuser.getMessagesUser(widget.user.idUsuario));
    }

    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (_timer.isActive) _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Constants.darkPrimary,
          title: Text(
            "Mensajes Actuales",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _timer?.cancel();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home(widget.user)));
            },
          ),
          actions: <Widget>[
            widget.user.tipoCliente.codigo != "adm"
                ? iconbutton(context)
                : Container(),
          ],
        ),
        body: FutureBuilder(
          future: widget.user.tipoCliente.codigo == "adm"
              ? messagesadm.getMessagesAdm()
              : messagesuser.getMessagesUser(widget.user.idUsuario),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return image();
            }

            switch(snapshot.connectionState){

              case ConnectionState.none:
                 return image();
                break;
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
                break;
              case ConnectionState.active:
             
             /*  if (widget.user.tipoCliente.codigo == "adm") {
                return _buildListView(snapshot.data);
                
              } else {
                return _listCliente(snapshot.data);
              } */
            
                break;
              case ConnectionState.done:
                if (widget.user.tipoCliente.codigo == "adm") {
                return _buildListView(snapshot.data);
                
              } else {
                return _listCliente(snapshot.data);
              }
                break;
            }
        
             return image();
          },
        ),
      ),
    );
  }

  Widget _listCliente(List<MessageUser> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          MessageUser profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                MessageDetalle item = new MessageDetalle();
                //dispose();
                _timer?.cancel();
                item.idmensaje = list[index].idmensaje;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpenChat(widget.user, item)));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.message,
                            color: Colors.pink,
                            size: 24.0,
                          ),
                          Text(
                            "  " + profile.titulo,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _buildListView(List<MessagesAdm> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          MessagesAdm profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                MessageDetalle item = new MessageDetalle();
                //dispose();
                _timer?.cancel();
                item.idmensaje = list[index].idmensaje;
            
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpenChat(widget.user, item)));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.message,
                            color: Colors.blue,
                            size: 24.0,
                          ),
                          Text(
                            "  " + profile.titulo,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }

  Widget image() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/nomessage.png",
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          Text("No posees mensajes"),
        ],
      ),
    );
  }

  Widget iconbutton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        _timer?.cancel();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateChatUser(widget.user)));
      },
    );
  }
}
